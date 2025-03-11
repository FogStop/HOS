<template>
  <div>
    <el-card>
    <div class="indexPeople2" style="margin-left: 50px">
      <div class="userImage">
        <i class="el-icon-user" style="font-size: 132px"></i>
      </div>

      <div class="userFont">
        <div class="spanCure">
          <span>就诊概况</span>
        </div>
        <div class="spanPeople">
          <span>今天预约挂号总人数：{{ orderPeople }}</span>
        </div>
      </div>
    </div>
    <P></P>

    <div class="indexPeople">
      <div class="userImage">
        <i class="el-icon-office-building" style="font-size: 132px"></i>
      </div>

      <div class="userFont">
        <div class="spanCure">
          <span>住院概况</span>
        </div>
        <div class="spanPeople">
          <span>今天住院总人数：{{ bedPeople }}</span>
        </div>
      </div>
    </div>
    <div class="indexGG">
      <span
        style="
          font-size: 17px;
          font-weight: bold;
          color: black;
          margin-left: 30px;
        "
        >系统公告</span
      >
      <div class="userGG">
        <el-table :data="tableData" style="width: 100%">
          <el-table-column prop="id" label="编号" width="180">
          </el-table-column>
          <el-table-column prop="time" label="发布日期" width="180">
          </el-table-column>
          <el-table-column prop="fileName" label="文件名" width="180">
          </el-table-column>
          <el-table-column prop="content" label="内容"> </el-table-column>
        </el-table>
      </div>
    </div>
    </el-card>
  </div>
</template>
<script>
import request from "@/utils/request.js";
export default {
  name: "AdminLayout",
  data() {
    return {
      orderPeople: 1,
      bedPeople: 1,
      tableData: [],
    };
  },
  methods: {
    requestPeople() {
      request
        .get("order/orderPeople")
        .then((res) => {
          if (res.data.status !== 200)
            return this.$message.error("数据请求失败");
          this.orderPeople = res.data.data;
        })
        .catch((err) => {
          console.error(err);
        });
    },
    requestBed() {
      request
        .get("bed/bedPeople")
        .then((res) => {
          if (res.data.status !== 200)
            return this.$message.error("数据请求失败");
          this.bedPeople = res.data.data;
        })
        .catch((err) => {
          console.error(err);
        });
    },
    getAnnouncements() {
      request
        .get("/announcements/list")
        .then((res) => {
          if (res.data.status !== 200) {
            return this.$message.error("数据错误咯");
          }
          this.tableData = res.data.data; // 确保res.data.data是一个数组
        })
        .catch((err) => {
          console.error("获取公告列表时出错:", err);
        });
    },
  },
  created() {
    this.requestPeople();
    this.requestBed();
    this.getAnnouncements();
  },
};
</script>
<style lang="scss" scoped>
.userFont {
  height: 150px;
  width: 250px;
  float: right;
  color: white;
  .spanCure {
    font-size: 15px;
    margin-top: 60px;
    margin-bottom: 15px;
  }
  .spanPeople {
    font-size: 18px;
  }
}

.indexPeople {
  height: 200px;
  width: 440px;
  background: linear-gradient(45deg, #49cce3, #5f72d5);
  border-radius: 20px;
  float: left;
  margin: 30px;
  display: flex;
  align-items: center;
  padding: 25px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
  transition: transform 0.3s ease;
  color: white;
}
.indexPeople2{
  height: 200px;
  width: 440px;
  background: linear-gradient(135deg, #2c3e50, #3498db);
  border-radius: 20px;
  float: left;
  margin: 30px;
  display: flex;
  align-items: center;
  padding: 25px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
  transition: transform 0.3s ease;
  color: white;
}
.indexPeople:hover,.indexPeople2:hover {
  transform: translateY(-5px);
}
.userImage i {
  font-size: 100px;
  margin-right: 25px;
  filter: drop-shadow(2px 2px 4px rgba(0, 0, 0, 0.2));
}
.indexGG {
  // height: 200px;
  width: 960px;
  background: #fffefe;
  // float: left;
  margin: 30px;
}
.userGG {
  // height: 300px;
  width: 100%;
  // float: right;
  color: white;
  margin-left: 20px;
}
</style>