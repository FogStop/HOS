<template>
  <div>
    <!-- 科室选择 -->
    <el-card class="department-card" shadow="hover" :body-style="{ padding: '20px' }">
      <el-divider>科室选择</el-divider>
      <div class="section-container">
        <div class="section-group">
          <i class="el-icon-monitor section-title"><b>内科</b></i>
          <ul class="section-list">
            <li v-for="inter in inters" :key="inter">
              <el-button
                type="primary"
                class="section-button"
                @click="sectionClick(inter)"
              >{{ inter }}</el-button>
            </li>
          </ul>
        </div>

        <el-divider></el-divider>

        <div class="section-group">
          <i class="el-icon-monitor section-title"><b>外科</b></i>
          <ul class="section-list">
            <li v-for="out in outs" :key="out">
              <el-button
                type="primary"
                class="section-button"
                @click="sectionClick(out)"
              >{{ out }}</el-button>
            </li>
          </ul>
        </div>

        <el-divider></el-divider>

        <div class="section-group">
          <i class="el-icon-monitor section-title"><b>妇产科</b></i>
          <ul class="section-list">
            <li v-for="woman in women" :key="woman">
              <el-button
                type="primary"
                class="section-button"
                @click="sectionClick(woman)"
              >{{ woman }}</el-button>
            </li>
          </ul>
        </div>

        <el-divider></el-divider>

        <div class="section-group">
          <i class="el-icon-monitor section-title"><b>儿科</b></i>
          <ul class="section-list">
            <li v-for="kid in kids" :key="kid">
              <el-button
                type="primary"
                class="section-button"
                @click="sectionClick(kid)"
              >{{ kid }}</el-button>
            </li>
          </ul>
        </div>

        <el-divider></el-divider>

        <div class="section-group">
          <i class="el-icon-monitor section-title"><b>五官科</b></i>
          <ul class="section-list">
            <li v-for="five in fives" :key="five">
              <el-button
                type="primary"
                class="section-button"
                @click="sectionClick(five)"
              >{{ five }}</el-button>
            </li>
          </ul>
        </div>

        <el-divider></el-divider>

        <div class="section-group">
          <i class="el-icon-monitor section-title"><b>中医科</b></i>
          <ul class="section-list">
            <li v-for="chinese in chineses" :key="chinese">
              <el-button
                type="primary"
                class="section-button"
                @click="sectionClick(chinese)"
              >{{ chinese }}</el-button>
            </li>
          </ul>
        </div>

        <el-divider></el-divider>

        <div class="section-group">
          <i class="el-icon-monitor section-title"><b>其他</b></i>
          <ul class="section-list">
            <li v-for="orther in orthers" :key="orther">
              <el-button
                type="primary"
                class="section-button"
                @click="sectionClick(orther)"
              >{{ orther }}</el-button>
            </li>
          </ul>
        </div>
      </div>
    </el-card>
  </div>
</template>

<style scoped lang="scss">
.department-card {
  background-color: #f9f9f9; /* Lighter card background */
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* More significant shadow for depth */
}

.section-container {
  display: flex;
  flex-direction: column;
  gap: 10px; /* Reduced gap for tighter spacing */
}

.section-group {
  margin-bottom: 10px; /* Reduced bottom margin */
}

.section-title {
  font-size: 22px; /* Size adjustment for better visibility */
  font-weight: bold;
  color: #5c5c5c; /* Darker color for titles */
  margin-bottom: 5px; /* Reduced margin */
}

.section-list {
  display: flex;
  flex-wrap: wrap; /* Allow buttons to wrap */
}

.section-button {
  margin: 5px; /* Margin between buttons */
  padding: 8px 15px; /* Slightly larger padding */
  font-size: 14px;
  transition: background-color 0.3s, transform 0.2s;
  border-radius: 5px; /* Rounded corners for buttons */
}

.section-button:hover {
  background-color: #409eff; /* Primary color for hover effect */
  color: white; /* Change text color on hover */
  transform: scale(1.05); /* Slightly enlarge the button on hover */
}

.el-divider {
  margin: 10px 0; /* Space adjustments for dividers */
  border-top: 2px solid #e4e7ed; /* Thicker divider for a modern look */
}
</style>

<script>
export default {
  name: "SectionIndex",
  data() {
    return {
      inters: [
        "神经内科",
        "呼吸与危重症医学科",
        "内分泌科",
        "消化内科",
        "心血管内科",
        "肾内科",
        "发热门诊",
      ],
      outs: [
        "手足外科",
        "普通外科",
        "肛肠外科",
        "神经外科",
        "泌尿外科",
        "骨科",
        "烧伤整形外科",
      ],
      women: ["妇科", "产科"],
      kids: ["儿科", "儿童保健科"],
      fives: ["耳鼻咽喉科", "眼科", "口腔科"],
      chineses: ["中医科"],
      orthers: ["康复医学科", "急诊科", "皮肤性病科", "功能科"],
    };
  },
  methods: {
    //科室点击
    sectionClick(section){
      this.$router.push({path: '/arrangeDoctor?section=' + section});

    },
  },
};
</script>