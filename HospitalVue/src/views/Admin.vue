<template>
  <el-container>
    <!-- 头部 -->
    <el-header class="header-container">
      <div class="head-bar">
        <div class="header-brand">
          <img src="@/assets/img/1.png" class="brand-logo" />
          <h1 class="brand-title">智慧医疗信息平台</h1>
        </div>

        <div class="user-panel">
          <div class="user-profile">
            <div class="user-avatar">
              <img
                src="@/assets/11.png"
                alt="管理员头像"
                class="avatar-image"
              >
            </div>
            <el-dropdown trigger="click" @command="handleCommand">
              <span class="user-greeting">
                欢迎您，<strong>{{ userName }}</strong> 管理员
                <i class="el-icon-arrow-down el-icon--right"></i>
              </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="logout" class="logout-btn">
                  <i class="el-icon-switch-button"></i>退出登录
                </el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
        </div>
      </div>
    </el-header>

    <el-container class="main-container">
      <!-- 侧边栏 -->
      <el-aside width="220px" class="nav-sidebar">
        <el-menu
          :default-active="activePath"
          class="nav-menu"
          active-text-color="#fff"
          @select="menuClick"
        >
          <el-menu-item index="adminLayout" class="nav-item">
            <i class="el-icon-s-home nav-icon"></i>
            <span class="nav-text">首页</span>
          </el-menu-item>

          <el-menu-item index="doctorList" class="nav-item">
            <i class="el-icon-user nav-icon"></i>
            <span class="nav-text">医生信息管理</span>
          </el-menu-item>

          <el-menu-item index="patientList" class="nav-item">
            <i class="el-icon-user-solid nav-icon"></i>
            <span class="nav-text">患者信息管理</span>
          </el-menu-item>

          <el-menu-item index="orderList" class="nav-item">
            <i class="el-icon-postcard nav-icon"></i>
            <span class="nav-text">挂号项目管理</span>
          </el-menu-item>

          <el-menu-item index="drugList" class="nav-item">
            <i class="el-icon-first-aid-kit nav-icon"></i>
            <span class="nav-text">药物信息管理</span>
          </el-menu-item>

          <el-menu-item index="checkList" class="nav-item">
            <i class="el-icon-monitor nav-icon"></i>
            <span class="nav-text">检查项目管理</span>
          </el-menu-item>

          <el-menu-item index="dataExpore" class="nav-item">
            <i class="el-icon-s-data nav-icon"></i>
            <span class="nav-text">住院管理</span>
          </el-menu-item>


          <el-menu-item index="arrangeIndex" class="nav-item">
            <i class="el-icon-news nav-icon"></i>
            <span class="nav-text">排班信息管理</span>
          </el-menu-item>

          <el-menu-item index="dataExpore" class="nav-item">
            <i class="el-icon-s-data nav-icon"></i>
            <span class="nav-text">数据统计分析</span>
          </el-menu-item>

          <el-menu-item index="bedList" class="nav-item">
            <i class="el-icon-office-building nav-icon"></i>
            <span class="nav-text">公告管理</span>
          </el-menu-item>
        </el-menu>
      </el-aside>

      <el-main class="content-area">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>
<script>
import jwtDecode from "jwt-decode";
import {
  getToken,
  clearToken,
  getActivePath,
  setActivePath,
} from "@/utils/storage.js";
export default {
  name: "Admin",
  data() {
    return {
      userName: "",
      activePath: "",
    };
  },
  methods: {
    handleCommand(command) {
      if (command === "logout") {
        this.$confirm("此操作将退出登录, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        })
          .then(() => {
            clearToken();
            this.$message({
              type: "success",
              message: "退出登录成功!",
            });
            this.$router.push("login");
          })
          .catch(() => {
            this.$message({
              type: "info",
              message: "已取消",
            });
          });
      }
    },
    //token解码
    tokenDecode(token) {
      if (token !== null) return jwtDecode(token);
    },
    //导航栏点击事件
    menuClick(path) {
      this.activePath = path;
      setActivePath(path);
      if (this.$route.path !== "/" + path) this.$router.push(path);
      console.log(path);
    },
    //退出登录
    logout() {
      this.$confirm("此操作将退出登录, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          clearToken();
          this.$message({
            type: "success",
            message: "退出登录成功!",
          });
          this.$router.push("login");
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消",
          });
        });
    },
  },
  created() {
    //  获取激活路径
    this.activePath = getActivePath();
    // 解码token
    this.userName = this.tokenDecode(getToken()).aName;
  },
};
</script>
<style scoped lang="scss">
.title {
  cursor: pointer;
}
/* 复用医生页面的样式变量和基础样式 */
$primary-blue: #427cb3;
$secondary-blue: #0c73a7;
$hover-blue: #5a9bd5;
$text-white: #ffffff;
$bg-gradient: linear-gradient(135deg, #427cb3 0%, #0c73a7 100%);

.header-container {
  background: $bg-gradient;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  height: 64px !important;
  padding: 0 30px;

  .head-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 100%;
  }

  .header-brand {
    display: flex;
    align-items: center;

    .brand-logo {
      width: 40px;
      height: 40px;
      margin-right: 15px;
      filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
    }

    .brand-title {
      color: $text-white;
      font-size: 20px;
      letter-spacing: 1.5px;
      text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      margin: 0;
    }
  }

  .user-panel {
    .user-profile {
      display: flex;
      align-items: center;

      .user-greeting {
        color: $text-white;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s;

        &:hover {
          color: darken($text-white, 10%);
        }

        strong {
          font-weight: 600;
        }
      }

      .user-avatar {
        margin-right: 12px;
        .avatar-image {
          width: 40px;
          height: 40px;
          border-radius: 50%;
          border: 2px solid rgba(255, 255, 255, 0.8);
          object-fit: cover;
          display: block;
        }
      }
    }

    .logout-btn {
      color: $primary-blue;
      padding: 10px 20px;

      i {
        margin-right: 8px;
      }
    }
  }
}

.nav-sidebar {
  background: $secondary-blue;
  box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);

  .nav-menu {
    background: transparent;
    border-right: none;
    padding: 20px 0;

    .nav-item {
      height: 50px;
      line-height: 50px;
      margin: 8px 15px;
      border-radius: 8px;
      transition: all 0.3s;

      &:hover {
        background: rgba(255, 255, 255, 0.1);
      }

      &.is-active {
        background: $hover-blue;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }

      .nav-icon {
        color: $text-white;
        font-size: 18px;
        margin-right: 12px;
      }

      .nav-text {
        color: $text-white;
        font-size: 14px;
        letter-spacing: 0.5px;
      }
    }
  }
}

.content-area {
  background: #f5f7fa;
  padding: 25px;
  min-height: calc(100vh - 64px);
}
</style>