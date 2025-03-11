<template>
  <div>
    <el-card class="appointment-card">
      <!-- 面包屑 -->
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/orderOperate' }">科室选择</el-breadcrumb-item>
        <el-breadcrumb-item>日期选择</el-breadcrumb-item>
        <el-breadcrumb-item>挂号</el-breadcrumb-item>
      </el-breadcrumb>

      <el-divider></el-divider>

      <!-- 医生列表 -->
      <div class="doctor-list-header">
        <i class="iconfont icon-r-user1" style="font-size: 26px">
          {{ sectionOpt }} 医生列表
        </i>
      </div>

      <div class="date-selection">
        <i class="iconfont icon-r-paper" style="font-size: 22px"> 请选择挂号日期：</i>
        <ul class="dateUl">
          <li v-for="monthDay in monthDays" :key="monthDay">
            <el-button
              type="primary"
              @click="dateClick(monthDay)"
              class="date-button"
            >{{ monthDay }}</el-button
            >
          </li>
        </ul>
      </div>

      <!-- 医生信息表格 -->
      <el-table :data="sectionData" stripe style="width: 100%" border>
        <el-table-column type="index" label="序号" width="60"></el-table-column>
        <el-table-column prop="dId" label="工号" width="80"></el-table-column>
        <el-table-column prop="dName" label="姓名" width="80"></el-table-column>
        <el-table-column prop="dGender" label="性别" width="60"></el-table-column>
        <el-table-column prop="dPost" label="职位" width="100"></el-table-column>
        <el-table-column prop="dSection" label="科室" width="100"></el-table-column>
        <el-table-column prop="dPrice" label="挂号费用(元)" width="120"></el-table-column>
        <el-table-column prop="dAvgStar" label="评价(分)" width="80"></el-table-column>
        <el-table-column label="操作" width="140">
          <template slot-scope="scope">
            <el-button
              type="warning"
              @click="openClick(scope.row.dId, scope.row.dName)"
              class="appointment-button"
            >挂号</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 挂号对话框 -->
    <el-dialog title="填写挂号信息" :visible.sync="orderFormVisible">
      <el-form :model="orderForm" ref="orderForm" :rules="orderRules">
        <el-form-item label="挂号时间段" prop="oTime">
          <el-select v-model="orderForm.oTime" placeholder="请选择">
            <el-option v-for="time in times" :key="time" :label="time" :value="time"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="挂号日期">
          <el-input v-model="orderForm.orderDate" disabled></el-input>
        </el-form-item>
        <el-form-item label="医生工号">
          <el-input v-model="orderForm.dId" disabled></el-input>
        </el-form-item>
        <el-form-item label="医生姓名">
          <el-input v-model="orderForm.dName" disabled></el-input>
        </el-form-item>
        <el-form-item label="患者姓名">
          <el-input v-model="orderForm.pName" disabled></el-input>
        </el-form-item>
        <el-form-item label="患者身份证号">
          <el-input v-model="orderForm.pCard" disabled></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="orderFormVisible = false" class="cancel-button">取 消</el-button>
        <el-button type="primary" @click="orderSuccess('orderForm')" class="confirm-button">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped lang="scss">
.dateUl {
  margin: 20px 0;
}
.dateUl li {
  display: inline-block;
  margin: 5px;
}
.appointment-card {
  margin-top: 20px;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
}
.doctor-list-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}
.iconfont {
  margin-right: 8px;
}
.date-button {
  transition: background-color 0.3s;
}
.date-button:hover {
  background-color: #30475e; /* Darker primary color */
}
.dialog-footer {
  display: flex;
  justify-content: flex-end;
}
.cancel-button {
  margin-right: 10px;
  font-size: 18px;
}
.confirm-button {
  font-size: 18px;
}
.el-breadcrumb{
  margin-bottom: 20px;
}
</style>

<script>
import jwtDecode from "jwt-decode";
import request from "@/utils/request.js";
import { getToken } from "@/utils/storage.js";
export default {
  name: "sectionMessage",
  data() {
    return {
      sectionOpt: this.$route.query.sectionOpt,
      sectionData: [],
      monthDays: [],
      clickTag: false,
      orderFormVisible: false,
      orderForm: { orderDate: "" },
      times: [],
      orderRules: {
        oTime: [
          { required: true, message: "选择时间段", trigger: "blur" },
        ],
      },
      //挂号日期
      orderDate: "",
      //拼接时间和日期成为oId
      idTime: "",
    };
  },
  methods: {
    //打开挂号对话框触发,获取挂号时间段已剩余票数
    requestTime(id) {
      this.idTime = id + this.orderDate;
      request
        .get("order/findOrderTime", {
          params: {
            arId: this.idTime,
          },
        })
        .then((res) => {
          const date = new Date(this.orderDate);
          const today = new Date();
          const isToday =
            date.getFullYear() === today.getFullYear() &&
            date.getMonth() === today.getMonth() &&
            date.getDate() === today.getDate();
          var array = [];
          if (!this.isTimeAfterTarget("09:30") || !isToday) {
            array.push(
              "08:30-09:30  " + "   余号 " + res.data.data.eTOn
            );
          }
          if (!this.isTimeAfterTarget("10:30") || !isToday) {
            array.push(
              "09:30-10:30  " + "   余号 " + res.data.data.nTOt
            );
          }
          if (!this.isTimeAfterTarget("11:30") || !isToday) {
            array.push(
              "10:30-11:30  " + "   余号 " + res.data.data.tTOe
            );
          }
          if (!this.isTimeAfterTarget("15:30") || !isToday) {
            array.push(
              "14:30-15:30  " + "   余号 " + res.data.data.fTOf
            );
          }
          if (!this.isTimeAfterTarget("16:30") || !isToday) {
            array.push(
              "15:30-16:30  " + "   余号 " + res.data.data.fTOs
            );
          }
          if (!this.isTimeAfterTarget("17:30") || !isToday) {
            array.push(
              "16:30-17:30  " + "   余号 " + res.data.data.sTOs
            );
          }
          this.times = array;
        });
    },
    isTimeAfterTarget(timeString) {
      // 判断时间是否超过timeString(入参格式如：09:30)
      const currentTime = new Date();

      // 解析传入的目标时间字符串，获取小时和分钟
      const [targetHour, targetMinute] = timeString.split(":");

      // 设置要比较的时间
      const targetTime = new Date();
      targetTime.setHours(targetHour);
      targetTime.setMinutes(targetMinute);
      targetTime.setSeconds(0);

      // 比较当前时间是否超过了目标时间
      return currentTime > targetTime;
    },
    //挂号点击确认
    orderSuccess(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          request
            .get("patient/addOrder", {
              params: {
                pId: this.orderForm.pId,
                dId: this.orderForm.dId,
                oStart:
                  this.orderForm.orderDate +
                  " " +
                  this.orderForm.oTime,
                arId: this.idTime,
              },
            })
            .then((res) => {
              if (res.data.status != 200)
                return this.$message.error(
                  "该时间段无剩余号源！请重新选择！"
                );
              this.orderFormVisible = false;
              this.$message.success("挂号成功！");
              this.orderForm.oTime = '';
            });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    //token解码
    tokenDecode(token) {
      if (token !== null) return jwtDecode(token);
    },
    //打开挂号对话框
    openClick(id, name) {
      this.orderForm.dId = id;
      this.orderForm.dName = name;
      this.orderFormVisible = true;
      //请求挂号时间段
      this.requestTime(id);
    },
    //选择日期触发时间
    dateClick(date) {
      //获取挂号年月日
      const nowDate = new Date();
      let year = nowDate.getFullYear();
      this.orderForm.orderDate = year + "-" + date;
      let dateYear = year + "-" + date;
      this.orderDate = dateYear;
      request
        .get("/arrange/findByTime", {
          params: {
            arTime: dateYear,
            dSection: this.sectionOpt,
          },
        })
        .then((res) => {
          //this.sectionData.dId = res.data.data.doctors.dId;
          /**
           * 重点！！！把数组中的对象取出来用map
           */
          this.sectionData = res.data.data.map((item) => item.doctor);
          this.clickTag = true;
          console.log(res.data.data.map((item) => item.doctor));
          //console.log(res.data.data[0].doctor);
        });
    },
    //获取当天及后7天的日期星期
    nowDay(num) {
      var nowDate = new Date();
      var currentHour = nowDate.getHours();
      var currentMinute = nowDate.getMinutes();

      // 判断当前时间是否已经过了17:30
      if (
        currentHour > 17 ||
        (currentHour === 17 && currentMinute > 30)
      ) {
        num++; // 次日
      }

      nowDate.setDate(nowDate.getDate() + num);
      var month = nowDate.getMonth() + 1;
      var date = nowDate.getDate();
      if (date < 10) {
        date = "0" + date;
      }
      if (month < 10) {
        month = "0" + month;
      }
      var time = month + "-" + date;
      this.monthDays.push(time);
    },
    //请求部门医生信息
    requestSection() {
      request
        .get("patient/findDoctorBySection", {
          params: {
            dSection: this.$route.query.sectionOpt,
          },
        })
        .then((res) => {
          if (res.data.status !== 200)
            return this.$message.error("请求数据失败");
          this.sectionData = res.data.data.doctors;
          console.log(res.data.data.doctors);
        });
    },
  },
  created() {
    //获取当天的后7天
    for (var i = 0; i < 7; i++) {
      this.nowDay(i);
    }
    //按科室请求医生信息
    this.requestSection();
    // 解码token
    this.orderForm.pName = this.tokenDecode(getToken()).pName;
    this.orderForm.pCard = this.tokenDecode(getToken()).pCard;
    this.orderForm.pId = this.tokenDecode(getToken()).pId;
    //console.log(this.orderForm.pId)
  },
};
</script>