<template>
    <div>
<!--   管理员-公告管理页面   -->
      <el-card>
        <div class="header">
          <el-input
            v-model="searchFileName"
            placeholder="请输入文件名搜索"
            style="width: 300px; margin-left: 20px"
            @keyup.enter.native="handleSearch"
          >
            <el-button slot="append" icon="el-icon-search" @click="handleSearch"></el-button>
          </el-input>
          <el-button type="primary" style="margin-left: 20px" @click="handleAdd" icon="el-icon-circle-plus-outline" >发布公告</el-button>
        </div>
      <div class="indexGG">
        <span style="font-size: 17px;font-weight: bold ;color: black;margin-left: 30px;">系统公告</span>
        <div class="userGG">
          <el-table
            :data="tableData"
            style="width: 100%">
            <el-table-column
             align="center"
              prop="id"
              label="编号"
              width="180">
            </el-table-column>
            <el-table-column
              prop="time"
              label="发布日期"
              align="center"
              width="180">
            </el-table-column>
            <el-table-column
              prop="fileName"
              label="文件名"
              align="center"
              width="180">
            </el-table-column>
            <el-table-column
              prop="content"
              align="center"

              label="内容">
            </el-table-column>
            <el-table-column label="操作" align="center" width="150" >
              <template slot-scope="scope">
                <el-button size="mini" @click.stop="handleEdit(scope.row)" type="success" icon="el-icon-edit"></el-button>
                <el-popconfirm title="确认删除该公告吗？" @confirm="handleDelete(scope.row.id)">
                  <el-button slot="reference" size="mini" type="danger" @click.stop icon="el-icon-delete" ></el-button>
                </el-popconfirm>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>
       <!-- 新增/编辑弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="30%">
      <el-form :model="form" :rules="rules" ref="form">
        <el-form-item label="文件名" prop="fileName" >
          <el-input v-model="form.fileName"></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="form.content" type="textarea" rows="4"></el-input>
        </el-form-item>
        <el-form-item label="日期" prop="time">
          <el-date-picker
            v-model="form.time"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          ></el-date-picker>
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">确认</el-button>
      </span>
    </el-dialog>

      </el-card>
    </div>
</template>
<script>
import request from "@/utils/request.js";
export default {
    name: "CheckList",
    data() {
        return {
            tableData: [],
             searchFileName: '',
      dialogVisible: false,
      dialogTitle: '新增公告',
          form: {
        id: null,
        fileName: '',
        content: '',
        time: new Date().toISOString().slice(0, 10)
      },
      rules: {
        fileName: [{ required: true, message: '请输入文件名', trigger: 'blur' }],
        content: [{ required: true, message: '请输入内容', trigger: 'blur' }],
        time: [{ required: true, message: '请选择日期', trigger: 'change' }]
      }

        };
    },
      mounted() {
    this.loadData()
  },
    methods: {
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
      async loadData() {
    try {
      const res = await request.get('/announcements', {
        params: { fileName: this.searchFileName }
      });
      
      if (res.data.status === 200) {
        this.tableData = res.data.data;
      } else {
        this.$message.error(res.data.msg || '查询失败');
      }
    } catch (err) {
      console.error('加载数据失败:', err);
      this.$message.error('数据加载失败，请检查网络');
    }
  },

  handleSearch() {
    this.loadData();
  },

  handleAdd() {
    this.dialogTitle = '新增公告';
    this.form = {
      id: null,
      fileName: '',
      content: '',
      time: new Date().toISOString().slice(0, 10)
    };
    this.dialogVisible = true;
  },

  handleEdit(row) {
    this.dialogTitle = '编辑公告';
    this.form = { ...row };
    this.dialogVisible = true;
  },

  async submitForm() {
    this.$refs.form.validate(async valid => {
      if (valid) {
        try {
          const method = this.form.id ? 'put' : 'post';
          const res = await request[method]('/announcements', this.form);
          
          if (res.data.status === 200) {
            this.$message.success(res.data.msg || '操作成功');
            this.dialogVisible = false;
            await this.loadData();
          } else {
            this.$message.error(res.data.msg || '操作失败');
          }
        } catch (err) {
          console.error('提交失败:', err);
          this.$message.error('操作失败，请重试');
        }
      }
    });
  },

  async handleDelete(id) {
    try {
      const res = await request.delete(`/announcements/${id}`);
      
      if (res.data.status === 200) {
        this.$message.success(res.data.msg || '删除成功');
        await this.loadData();
      } else {
        this.$message.error(res.data.msg || '删除失败');
      }
    } catch (err) {
      console.error('删除失败:', err);
      this.$message.error('删除失败，请重试');
    }
  }

    },
    created() {
        this.getAnnouncements();
    },
};
</script>
<style scoped lang="scss">
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
.title {
  font-size: 17px;
  font-weight: bold;
  color: black;
}
</style>