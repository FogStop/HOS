<template>
  <!-- 管理员-排班信息管理 -->
  <div>
    <el-card shadow="hover" class="card-container">
      <div class="header-title">
        <i class="el-icon-date icon-title"></i>
        <span>请选择值班日期：</span>
      </div>
      <el-divider></el-divider>
      <ul class="dateUl">
        <li v-for="monthDay in monthDays" :key="monthDay">
          <el-button
            icon="el-icon-date"
            type="primary"
            @click="dateClick(monthDay)"
            class="date-button"
          >
            {{ monthDay }}
          </el-button>
        </li>
      </ul>
    </el-card>

    <div class="router-view">
      <router-view></router-view>
    </div>
  </div>
</template>

<style scoped lang="scss">
.card-container {
  padding: 20px;
  background-color: #f5f7fa; /* Card background */
  border-radius: 12px; /* Rounded corners */
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.header-title {
  display: flex;
  align-items: center;
  font-size: 18px; /* Increased font size */
  color: #333;
}

.icon-title {
  font-size: 28px; /* Increased icon size */
  margin-right: 10px; /* Space between icon and text */
  color: #409eff; /* Primary color for the icon */
}

.dateUl {
  margin-top: 15px; /* Space above the date list */
  display: flex; /* Align items in single row */
  flex-wrap: wrap; /* Items wrap to next line */
}

.dateUl li {
  margin: 5px; /* Space around each button */
}

.date-button {
  height: 40px; /* Button height */
  border-radius: 5px; /* Slightly rounded corners */
  transition: background-color 0.3s, transform 0.2s; /* Add transition effects */
}

.date-button:hover {
  background-color: #3f9efc; /* Change background on hover */
  transform: translateY(-2px); /* Add slight lifting effect */
}

.router-view {
  margin-top: 20px; /* Space above the router view */
}
</style>

<script>
import { getActivePath, setActivePath } from "@/utils/storage.js";
const ARRANGEDATE = "arrangeDate";
export default {
  name: "ArrangeIndex",
  data() {
    return {
      monthDays: [],
      monthDay: "",
      activePath: "",
    };
  },

  methods: {
    //日历点击
    dateClick(monthDay) {
      console.log(monthDay);

      const nowDate = new Date();
      let year = nowDate.getFullYear();
      let dateTime = year + "-" + monthDay;
      sessionStorage.setItem(ARRANGEDATE, dateTime);

      this.activePath = "sectionIndex";
      setActivePath("sectionIndex");
      if (this.$route.path !== "/sectionIndex")
        this.$router.push("sectionIndex");
    },
    //获取当天及后7天的日期星期
    nowDay(num) {
      var nowDate = new Date();
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
  },
  created() {
    //获取当天的后7天
    for (var i = 0; i < 25; i++) {
      this.nowDay(i);
      //  获取激活路径
      this.activePath = getActivePath();
    }
  },
};
</script>

<style scoped lang="scss">
.disabled {
    background-color: #ddd;
    border-color: #ddd;
    color: black;
    cursor: not-allowed; // 鼠标变化
    pointer-events: none;
}
.router-view {
    margin-top: 20px;
}
.sectionUl li {
    display: inline;
    padding: 60px;
}
.dateUl li {
    display: inline;
    //margin: 5px;
    padding: 1px;
}
</style>