<template>
  <!-- 患者-挂号医生信息页面 -->
  <div class="doctor-profile-container">
    <el-card shadow="hover" class="profile-card">
      <div class="profile-header">
        <h2 class="doctor-name">{{ doctorData.dName }} 医生</h2>
        <div class="doctor-meta">
          <span class="meta-item"><i class="el-icon-user"></i> {{ doctorData.dGender }}</span>
          <span class="meta-item"><i class="el-icon-office-building"></i> {{ doctorData.dSection }}</span>
          <span class="meta-item rating"><i class="el-icon-star-on"></i> 评分 {{ doctorData.dAvgStar }}</span>
        </div>
      </div>

      <el-row :gutter="30" class="info-section">
        <el-col :span="12" v-for="(item, index) in leftItems" :key="index">
          <div class="info-item">
            <label>{{ item.label }}</label>
            <el-input
              v-model="doctorData[item.prop]"
              :disabled="item.disabled"
              class="info-input"
              :class="{ 'disabled-input': item.disabled }"
            ></el-input>
          </div>
        </el-col>

        <el-col :span="12" v-for="(item, index) in rightItems" :key="index+6">
          <div class="info-item">
            <label>{{ item.label }}</label>
            <el-input
              v-model="doctorData[item.prop]"
              :disabled="item.disabled"
              class="info-input"
              :class="{ 'disabled-input': item.disabled }"
            ></el-input>
          </div>
        </el-col>
      </el-row>

      <div class="introduction-section">
        <h3 class="section-title"><i class="el-icon-document"></i> 医生简介</h3>
        <el-input
          type="textarea"
          :rows="4"
          v-model="doctorData.dIntroduction"
          class="intro-textarea"
          resize="none"
        ></el-input>
      </div>
    </el-card>
  </div>
</template>

<style scoped lang="scss">
.doctor-profile-container {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;

  .profile-card {
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);

    .profile-header {
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 1px solid #eee;

      .doctor-name {
        color: #2c3e50;
        font-size: 24px;
        margin-bottom: 10px;
      }

      .doctor-meta {
        .meta-item {
          margin-right: 25px;
          color: #7f8c8d;
          font-size: 14px;

          i {
            margin-right: 5px;
            color: #409EFF;
          }

          &.rating {
            color: #f39c12;
            i { color: #f39c12; }
          }
        }
      }
    }

    .info-section {
      margin-bottom: 25px;

      .info-item {
        margin-bottom: 20px;

        label {
          display: block;
          color: #666;
          font-size: 14px;
          margin-bottom: 8px;
          font-weight: 500;
        }

        .info-input {
          width: 100%;

          &::v-deep .el-input__inner {
            border-radius: 8px;
            background-color: #f8f9fa;
            border-color: #e9ecef;
            color: #495057;
            height: 40px;
            line-height: 40px;

            &:focus {
              border-color: #409EFF;
              box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
            }
          }

          &.disabled-input::v-deep .el-input__inner {
            background-color: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
          }
        }
      }
    }

    .introduction-section {
      .section-title {
        color: #2c3e50;
        font-size: 18px;
        margin-bottom: 15px;

        i {
          color: #409EFF;
          margin-right: 8px;
        }
      }

      .intro-textarea::v-deep .el-textarea__inner {
        border-radius: 8px;
        background-color: #f8f9fa;
        border-color: #e9ecef;
        color: #495057;
        font-size: 14px;
        line-height: 1.6;
        padding: 12px;
      }
    }
  }
}
</style>

<script>
export default {
  data() {
    return {
      doctorData: {
        // 示例数据
        dName: '王医生',
        dGender: '男',
        dId: 'D1001',
        dPhone: '138-1234-5678',
        dCard: '310***************',
        dEmail: 'doctor@hospital.com',
        dPost: '主任医师',
        dSection: '心血管内科',
        dPrice: '50元',
        dAvgStar: '4.8',
        dIntroduction: '具有10年临床经验，擅长心血管疾病诊治...'
      },
      leftItems: [
        { label: '医生账号', prop: 'dId', disabled: true },
        { label: '联系电话', prop: 'dPhone', disabled: false },
        { label: '身份证号', prop: 'dCard', disabled: true },
        { label: '电子邮箱', prop: 'dEmail', disabled: false }
      ],
      rightItems: [
        { label: '医生职位', prop: 'dPost', disabled: true },
        { label: '所属科室', prop: 'dSection', disabled: true },
        { label: '挂号费用', prop: 'dPrice', disabled: true },
        { label: '用户评分', prop: 'dAvgStar', disabled: true }
      ]
    }
  }
}
</script>

<script>
import jwtDecode from "jwt-decode";
import { getToken } from "@/utils/storage.js";
import request from "@/utils/request.js";
export default {
  name: "DoctorCard",
  data() {
    return {
      userId: "",
      doctorData: {},
    };
  },
  methods: {
    //请求医生信息
    requestDoctor() {
      request
        .get("admin/findDoctor", {
          params: {
            dId: this.userId,
          },
        })
        .then((res) => {
          if (res.data.status != 200)
            return this.$message.error("获取数据失败");
          this.doctorData = res.data.data;
        });
    },
    //token解码
    tokenDecode(token) {
      if (token !== null) return jwtDecode(token);
    },
  },
  created() {
    //解码token信息
    this.userId = this.tokenDecode(getToken()).dId;
    this.requestDoctor();
    console.log(this.userId);
  },
};
</script>