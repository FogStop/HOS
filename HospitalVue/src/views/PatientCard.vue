<template>
  <!-- 患者卡片列表 -->
  <div class="patient-card-container">
    <el-card class="patient-card" shadow="hover">
      <h2 class="card-title">个人信息</h2>
      <table class="patient-table">
        <tr>
          <td>姓名：</td>
          <td><el-input disabled v-model="patientData.pName"></el-input></td>
        </tr>
        <tr>
          <td>账号：</td>
          <td><el-input disabled v-model="patientData.pId"></el-input></td>
        </tr>
        <tr>
          <td>性别：</td>
          <td><el-input disabled v-model="patientData.pGender"></el-input></td>
        </tr>
        <tr>
          <td>手机号：</td>
          <td><el-input v-model="patientData.pPhone"></el-input></td>
        </tr>
        <tr>
          <td>身份证号：</td>
          <td><el-input disabled v-model="patientData.pCard"></el-input></td>
        </tr>
        <tr>
          <td>邮箱：</td>
          <td><el-input v-model="patientData.pEmail"></el-input></td>
        </tr>
        <tr>
          <td>出生日期：</td>
          <td><el-input v-model="patientData.pBirthday"></el-input></td>
        </tr>
        <tr>
          <td>年龄：</td>
          <td><el-input v-model="patientData.pAge"></el-input></td>
        </tr>
      </table>
    </el-card>
  </div>
</template>

<style lang="scss" scoped>
.patient-card-container {
  width: 100%;
  margin-top: -10px;
  display: flex;
  justify-content: center; /* Center the card horizontally */
  padding: 20px; /* Add padding overall */
}

.patient-card {
  width: 100%;
  max-width: 600px; /* Limit the card width */
  border-radius: 10px;
  box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s;
}

.patient-card:hover {
  transform: scale(1.02); /* Slightly enlarge card on hover */
}

.card-title {
  font-size: 24px;
  font-weight: bold;
  text-align: center; /* Center the title */
  padding: 10px 0; /* Add padding for spacing */
  color: #333; /* Dark grey color for title */
}

.patient-table {
  width: 100%;
  border-collapse: collapse; /* Remove spacing between borders */
}

.patient-table td {
  white-space: nowrap; /* Prevent breaking of words in cells */
  padding: 12px; /* Space between text and cell borders */
  border-bottom: 1px solid #ddd; /* Add light grey bottom border */
}

.patient-table tr:hover {
  background-color: #f9f9f9; /* Light grey background on row hover */
}
</style>

<script>
import jwtDecode from "jwt-decode";
import { getToken } from "@/utils/storage.js";
import request from "@/utils/request.js";
export default {
  name: "PatientCard",
  data() {
    return {
      userId: "",
      patientData: {},
    };
  },
  methods: {
    //请求患者信息
    requestPatient() {
      request
        .get("doctor/findPatientById", {
          params: {
            pId: this.userId,
          },
        })
        .then((res) => {
          if (res.data.status != 200)
            return this.$message.error("获取数据失败");
          this.patientData = res.data.data;
        });
    },
    //token解码
    tokenDecode(token) {
      if (token !== null) return jwtDecode(token);
    },
  },
  created() {
    //解码token信息
    this.userId = this.tokenDecode(getToken()).pId;
    this.requestPatient();
    console.log(this.userId);
  },
};
</script>