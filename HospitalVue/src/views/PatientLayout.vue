<template>
  <div>
    <el-card>
      <div class="container">
        <div class="timeCard">
          <div class="userImage">
            <i class="el-icon-time"></i>
          </div>
          <div class="date-section">
            <div class="year-month-day">{{ currentDate }}</div>
            <div class="time">{{ currentTime }}</div>
          </div>
        </div>
        <!--  时间卡片    -->
        <div class="indexPeople">
          <div class="userImage">
            <i class="el-icon-user-solid"></i>
          </div>
          <!-- 个人信息卡片 -->
          <div class="userFont">
            <div class="spanCure">
              <ul>
                <li>姓名：{{ userName }}</li>
                <li>性别：{{ patientInfo.pGender }}</li>
                <li>年龄：{{ patientInfo.pAge }}</li>
                <li>联系方式：{{ patientInfo.pPhone }}</li>
                <li>身份证：{{ patientInfo.pCard }}</li>
                <li>出生日期：{{ patientInfo.pBirthday }}</li>
                <li>上次主治医生：{{ orderData.dName }}</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="fixed-window">
          <div class="window-title">
            <i class="el-icon-magic-stick"></i>
            智慧助手
          </div>
          <div class="ai-assistant" @click="openAIPanel">
            <i class="el-icon-connection ai-icon"></i>
            <div>智能AI助手</div>
            <i class="el-icon-arrow-right" style="margin-left: auto;"></i>
          </div>
        </div>
      </div>
      <div class="indexGG">
        <span style="font-size: 17px;font-weight: bold ;color: black;margin-left: 30px;">系统公告</span>
        <div class="userGG">
          <el-table
            :data="tableData"
            style="width: 100%">
            <el-table-column
              prop="id"
              label="编号"
              width="180">
            </el-table-column>
            <el-table-column
              prop="time"
              label="发布日期"
              width="180">
            </el-table-column>
            <el-table-column
              prop="fileName"
              label="文件名"
              width="180">
            </el-table-column>
            <el-table-column
              prop="content"
              label="内容">
            </el-table-column>
          </el-table>
        </div>
      </div>
      <!--  弹窗    -->
      <div class="ai-popup" v-if="showAIPanel">
        <div class="ai-mask" @click="showAIPanel = false"></div>
        <div class="ai-container">
          <div class="ai-header">
            <span>AI 智慧助手</span>
            <i class="el-icon-close" @click="showAIPanel = false"></i>
          </div>
          <div class="ai-content">
            <div class="ai-dialog">
              <div class="ai-message">开发中，敬请期待.............</div>
            </div>
            <div class="ai-input-group">
              <el-input
                placeholder="请输入您的问题"
                v-model="aiQuestion"
                class="ai-input"
              >
                <template #append>
                  <el-button type="primary" @click="handleAISubmit">
                    发送
                    <i class="el-icon-position"></i>
                  </el-button>
                </template>
              </el-input>
            </div>
          </div>
        </div>
      </div>
    </el-card>
  </div>
</template>
<script>
import request from "@/utils/request.js";
import jwtDecode from "jwt-decode";
import { getToken } from "@/utils/storage";

export default {
  name: "PatientLayout",
  data() {
    return {
      orderPeople: 1,
      userId: "",
      bedPeople: 1,
      tableData: [],
      userName: "",
      patientInfo: [],
      currentDate: "",
      orderData: [],
      currentTime: "",
      showAIPanel: false,
      aiQuestion: ''
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
    updateDateTime() {
      const now = new Date();
      const dateOptions = { year: "numeric", month: "long", day: "numeric" };
      const timeOptions = { hour: "2-digit", minute: "2-digit", second: "2-digit" };
      this.currentDate = now.toLocaleDateString("zh-CN", dateOptions);
      this.currentTime = now.toLocaleTimeString("zh-CN", timeOptions);
    },
    tokenDecode(token) {
      if (token !== null) return jwtDecode(token);
    },
    getPatientInfo() {
      request.get(`/patient/info/${this.userName}`)
        .then(res => {
          this.patientInfo = res.data.data;
          // console.log(patientInfo);
        });
    },
    //请求关联医生
    requestOrder() {
      request
        .get("patient/findOrderByPid", {
          params: {
            pId: this.userId
          }
        })
        .then((res) => {
          console.log(res.data.data);
          if (res.data.data.length > 0) {
            this.orderData = res.data.data[0];
          }
        });
    },
    openAIPanel() {
      this.showAIPanel = true;
    },

  },
  mounted() {
    // 每秒更新一次时间
    this.updateDateTime();
    setInterval(this.updateDateTime, 1000); // 每秒更新一次
  },
  beforeDestroy() {
    // 清除定时器
    clearInterval(this.timer);
  },
  created() {
    this.requestPeople();
    this.requestBed();
    this.getAnnouncements();
    this.userName = this.tokenDecode(getToken()).pName;
    const tokenData = this.tokenDecode(getToken());
    this.userId = tokenData.pId;  // 根据token中实际字段名调整
    this.getPatientInfo();
    this.requestOrder();
  }
};

</script>
<style lang="scss" scoped>
title {
  cursor: pointer;
}

.el-header {
  background-color: #427cb3;
  display: flex;
  justify-content: space-between;
  align-items: center;

  .words {
    text-align: center;

    span {
      color: black;
    }
  }

  //border-bottom: 1px solid lightgrey;
}

.el-container {
  height: 100%;
}

.el-aside {
  background-color: #353744;
  border-right: 1px solid lightgrey;
}

.el-menu {
  border: 0;
}

.head-bar {
  position: relative;
  box-sizing: border-box;
  width: 100%;
  height: 70px;
  font-size: 22px;
  color: #fff;

}

.header-ico {
  float: left;
  padding: 0 21px;
  line-height: 70px;
}

.head-bar .logo {
  float: left;
  width: 250px;
  line-height: 70px;
  margin-left: -25px;
}

.head-right {
  float: right;
  padding-right: 50px;
}

.head-user-con {
  display: flex;
  height: 70px;
  align-items: center;
}

.btn-fullscreen {
  transform: rotate(45deg);
  margin-right: 5px;
  font-size: 24px;
}

.btn-fullscreen {
  position: relative;
  width: 30px;
  height: 30px;
  text-align: center;
  border-radius: 15px;
  cursor: pointer;
}

.btn-bell .el-icon-bell {
  color: #fff;
}

.user-name {
  margin-left: 10px;
}

.user-avatar {
  margin-left: 20px;
}

.user-avatar img {
  display: block;
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.el-dropdown-link {
  color: #fff;
  cursor: pointer;
}

.el-dropdown-menu__item {
  text-align: center;
}

.userFont {
  height: 150px;
  width: 250px;
  float: right;
  color: white;
  flex: 1;

  .spanCure {
    font-size: 15px;
    margin-top: 20px;
    margin-bottom: 15px;
  }

  .spanPeople {
    font-size: 18px;
  }
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

/* 卡片样式 */
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

.indexPeople:hover {
  transform: translateY(-5px);
}

.userImage i {
  font-size: 100px;
  margin-right: 25px;
  filter: drop-shadow(2px 2px 4px rgba(0, 0, 0, 0.2));
}

.timeCard {
  height: 200px; /* 保持高度较矮 */
  width: 440px;
  background: linear-gradient(135deg, #2c3e50, #3498db); /* 更改背景颜色 */
  border-radius: 20px;
  float: left;
  margin: 30px;
  display: flex;
  align-items: center;
  justify-content: space-between; /* 使日期和星期分列显示 */
  padding: 20px; /* 减少内边距 */
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
  transition: transform 0.3s ease;
  color: white;
  font-family: "方正字迹-黄永刚手书 简";

}

.timeCard:hover {
  transform: translateY(-5px);
}

.date-section {
  text-align: center;
  line-height: 1.2;

  .year-month-day {
    font-size: 50px;
    margin-bottom: 12px;
  }

  .time {
    font-size: 45px;
    font-weight: 500;
    letter-spacing: 2px;
  }
}
.fixed-window {
  position: fixed;
  right: 40px;
  bottom: 30px;
  width: 180px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
  border-radius: 15px;
  box-shadow: 0 8px 30px rgba(0,0,0,0.15);
  color: white;
  z-index: 999;
  transition: all 0.3s ease;
}

.fixed-window:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 40px rgba(0,0,0,0.2);
}

.window-title {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 15px;
  display: flex;
  align-items: center;
  gap: 10px;
  border-bottom: 1px solid rgba(255,255,255,0.2);
  padding-bottom: 12px;
}

.ai-assistant {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-top: 15px;
  cursor: pointer;
  padding: 12px;
  border-radius: 8px;
  background: rgba(255,255,255,0.1);
  transition: background 0.3s;
}

.ai-assistant:hover {
  background: rgba(255,255,255,0.2);
}

.ai-icon {
  font-size: 24px;
  color: #ffd700;
}

.contact-info {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 14px;
}
.ai-popup {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 9999;
}

.ai-mask {
  position: absolute;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.5);
}

.ai-container {
  position: relative;
  width: 500px;
  height: 400px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 5px 20px rgba(0,0,0,0.2);
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  flex-direction: column;
}

.ai-header {
  padding: 15px 20px;
  background: #409EFF;
  color: white;
  border-radius: 12px 12px 0 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.ai-content {
  flex: 1;
  padding: 20px;
  display: flex;
  flex-direction: column;
}

.ai-dialog {
  flex: 1;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 20px;
}

.ai-input-group {
  margin-top: auto;
}

.ai-input {
  border-radius: 20px;
  overflow: hidden;
}

.el-icon-close {
  cursor: pointer;
  transition: 0.3s;
}

.el-icon-close:hover {
  transform: rotate(90deg);
}
</style>
