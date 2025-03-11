<template>
  <!-- 管理员-项目信息管理 -->
  <div class="manage-container">
    <el-card class="main-card">
      <!-- 搜索栏及增加检查 -->
      <div class="header-toolbar">
        <el-input
          v-model="query"
          placeholder="请输入名称查询"
          class="search-input"
          clearable
          @clear="requestChecks"
        >
          <el-button
            slot="append"
            icon="el-icon-search"
            @click="requestChecks"
          ></el-button>
        </el-input>

        <el-button
          type="primary"
          class="add-btn"
          @click="addFormVisible = true"
        >
          <i class="el-icon-circle-plus-outline"></i>
          新增项目
        </el-button>
      </div>

      <!-- 表格 -->
      <el-table
        :data="checkData"
        stripe
        style="width: 100%"
        class="data-table"
        header-cell-class-name="table-header"
      >
        <el-table-column
          label="编号"
          prop="chId"
          align="center"
          width="120"
        ></el-table-column>
        <el-table-column
          label="项目名称"
          prop="chName"
          align="center"
        ></el-table-column>
        <el-table-column
          label="价格（元）"
          align="center"
          prop="chPrice"
          width="150"
        >
          <template slot-scope="scope">
            <span class="price-tag">{{ scope.row.chPrice }}</span>
          </template>
        </el-table-column>
        <el-table-column
          label="操作"
          width="180"
          fixed="right"
          align="center"
        >
          <template slot-scope="scope">
            <el-tooltip content="编辑" placement="top">
              <el-button
                type="text"
                class="action-btn edit-btn"
                @click="modifyDialog(scope.row.chId)"
              >
                <i class="el-icon-edit-outline"></i>
              </el-button>
            </el-tooltip>

            <el-tooltip content="删除" placement="top">
              <el-button
                type="text"
                class="action-btn delete-btn"
                @click="deleteDialog(scope.row.chId)"
                style="padding-left: 1px"
              >
                <i class="el-icon-delete"></i>
              </el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination
        class="pagination"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="pageNumber"
        :page-sizes="[8, 16, 24, 32]"
        :page-size="size"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      ></el-pagination>
    </el-card>

    <!-- 增加检查项目对话框 -->
    <el-dialog title="增加检查项目" :visible.sync="addFormVisible">
      <el-form :model="addForm" :rules="rules" ref="ruleForm">
        <el-form-item label="编号" prop="chId" label-width="80px">
          <el-input v-model.number="addForm.chId"></el-input>
        </el-form-item>
        <el-form-item label="名称" prop="chName" label-width="80px">
          <el-input v-model="addForm.chName"></el-input>
        </el-form-item>
        <el-form-item label="价格" prop="chPrice" label-width="80px">
          <el-input v-model="addForm.chPrice"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addFormVisible = false" style="font-size: 18px;"><i class="el-icon-close"
                                                                               style="font-size: 20px;"></i> 取 消
        </el-button>
        <el-button type="primary" @click="addCheck('ruleForm')"
                   style="font-size: 18px;"><i class="el-icon-check" style="font-size: 20px;"></i> 确 定
        </el-button
        >
      </div>
    </el-dialog>

    <!-- 修改检查项目药物对话框 -->
    <el-dialog title="修改检查项目" :visible.sync="modifyFormVisible">
      <el-form :model="modifyForm" :rules="rules" ref="ruleForm">
        <el-form-item label="编号" prop="chId" label-width="80px">
          <el-input
            v-model.number="modifyForm.chId"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="名称" prop="chName" label-width="80px">
          <el-input v-model="modifyForm.chName"></el-input>
        </el-form-item>
        <el-form-item label="价格" prop="chPrice" label-width="80px">
          <el-input v-model="modifyForm.chPrice"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="modifyFormVisible = false" style="font-size: 18px;"><i class="el-icon-close"
                                                                                  style="font-size: 20px;"></i> 取 消
        </el-button>
        <el-button type="primary" @click="modifyCheck('ruleForm')"
                   style="font-size: 18px;"><i class="el-icon-check" style="font-size: 20px;"></i> 确 定
        </el-button
        >
      </div>
    </el-dialog>
  </div>
</template>

<style scoped lang="scss">
/* 颜色变量 */
$--color-primary: #409EFF;
$--color-success: #67C23A;
$--color-warning: #E6A23C;
$--color-danger: #F56C6C;
$--color-text-primary: #303133;
$--color-text-regular: #606266;
$--color-border: #EBEEF5;

.manage-container {
  padding: 20px;

  .main-card {
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);

    ::v-deep .el-card__body {
      padding: 24px;
    }
  }

  .header-toolbar {
    display: flex;
    align-items: center;
    margin-bottom: 24px;
    gap: 16px;

    .search-input {
      flex: 1;
      max-width: 400px;
    }

    .add-btn {
      padding: 12px 24px;

      i {
        margin-right: 8px;
        font-size: 16px;
      }
    }
  }

  .data-table {
    margin: 24px 0;
    border: 1px solid $--color-border;

    .table-header {
      background: #f8f9fa !important;
      color: $--color-text-primary;
      font-weight: 600;
    }

    .price-tag {
      display: inline-block;
      padding: 4px 12px;
      background: #f0f9ff;
      border-radius: 4px;
      color: $--color-primary;
    }

    .action-btn {
      padding: 8px;
      font-size: 16px;

      &.edit-btn {
        color: $--color-primary;

        &:hover {
          color: lighten($--color-primary, 10%);
        }
      }

      &.delete-btn {
        color: $--color-danger;

        &:hover {
          color: lighten($--color-danger, 10%);
        }
      }
    }
  }

  .pagination {
    margin-top: 24px;
    justify-content: flex-end;
  }

  .form-dialog {
    ::v-deep .el-dialog {
      border-radius: 8px;

      &__header {
        border-bottom: 1px solid $--color-border;
        padding: 16px 24px;
      }

      &__body {
        padding: 24px;
      }

      &__footer {
        padding: 16px 24px;
        border-top: 1px solid $--color-border;
      }
    }

    .el-form-item {
      margin-bottom: 20px;

      &__label {
        color: $--color-text-regular;
        padding-right: 16px;
      }
    }

    .dialog-footer {
      .el-button {
        padding: 10px 24px;

        i {
          margin-right: 8px;
        }
      }
    }
  }
}
</style>

<script>
import request from "@/utils/request.js";

export default {
  name: "CheckList",
  data() {
    return {
      pageNumber: 1,
      size: 8,
      query: "",
      checkData: [],
      total: 3,
      addFormVisible: false,
      addForm: {},
      rules: {
        chId: [
          { required: true, message: "请输入编号", trigger: "blur" },
          {
            type: "number",
            message: "账号必须数字类型",
            trigger: "blur"
          }
        ],
        chName: [
          { required: true, message: "请输入名称", trigger: "blur" },
          {
            min: 1,
            max: 50,
            message: "账号必须是1到50个字符",
            trigger: "blur"
          }
        ],
        chPrice: [
          { required: true, message: "请输入单价", trigger: "blur" }
        ]
      },
      modifyFormVisible: false,
      modifyForm: {}
    };
  },
  methods: {
    //点击修改药物信息
    modifyCheck(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          request
            .get("check/modifyCheck", {
              params: {
                chId: this.modifyForm.chId,
                chName: this.modifyForm.chName,
                chPrice: this.modifyForm.chPrice
              }
            })
            .then((res) => {
              if (res.data.status !== 200)
                return this.$message.error("修改信息失败！");
              this.modifyFormVisible = false;
              this.requestChecks();
              this.$message.success("修改检查项目信息成功！");
              console.log(res);
            });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    //打开修改对话框
    modifyDialog(id) {
      request
        .get("check/findCheck", {
          params: {
            chId: id
          }
        })
        .then((res) => {
          if (res.data.status !== 200)
            return this.$message.error("请求数据失败");
          this.modifyForm = res.data.data;
          this.modifyFormVisible = true;
          console.log(res);
        });
    },
    //删除检查操作
    deleteCheck(id) {
      request
        .get("check/deleteCheck", {
          params: {
            chId: id
          }
        })
        .then((res) => {
          this.requestChecks();
          console.log(res);
        });
    },
    //删除对话框
    deleteDialog(id) {
      this.$confirm("此操作将删除该检查项目信息, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.deleteCheck(id);
          this.$message({
            type: "success",
            message: "删除成功!"
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    //点击增加确认按钮
    addCheck(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          request
            .get("check/addCheck", {
              params: {
                chId: this.addForm.chId,
                chName: this.addForm.chName,
                chPrice: this.addForm.chPrice
              }
            })
            .then((res) => {
              if (res.data.status !== 200)
                return this.$message.error(
                  "编号不合法或已被占用！"
                );
              this.addFormVisible = false;
              this.requestChecks();
              this.$message.success("增加检查项目成功！");
              console.log(res);
            });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    //页面大小改变时触发
    handleSizeChange(size) {
      this.size = size;
      this.requestChecks();
    },
    //   页码改变时触发
    handleCurrentChange(num) {
      console.log(num);
      this.pageNumber = num;
      this.requestChecks();
    },
    // 加载检查列表
    requestChecks() {
      request
        .get("check/findAllChecks", {
          params: {
            pageNumber: this.pageNumber,
            size: this.size,
            query: this.query
          }
        })
        .then((res) => {
          this.checkData = res.data.data.checks;
          this.total = res.data.data.total;
          console.log(res.data.data);
        });
    }
  },
  created() {
    this.requestChecks();
  }
};
</script>