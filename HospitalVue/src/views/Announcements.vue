<template>
  <div class="indexGG">
    <div class="header">
      <span class="title">系统公告</span>
      <el-input
        v-model="searchFileName"
        placeholder="请输入文件名搜索"
        style="width: 300px; margin-left: 20px"
        @keyup.enter.native="handleSearch"
      >
        <el-button slot="append" icon="el-icon-search" @click="handleSearch"></el-button>
      </el-input>
      <el-button type="primary" style="margin-left: 20px" @click="handleAdd">新增公告</el-button>
    </div>

    <div class="userGG">
      <el-table
        :data="tableData"
        style="width: 100%"
        border
        @row-click="handleRowClick"
      >
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="id" label="编号" width="100"></el-table-column>
        <el-table-column prop="time" label="发布日期" width="150"></el-table-column>
        <el-table-column prop="fileName" label="文件名" width="200"></el-table-column>
        <el-table-column prop="content" label="内容"></el-table-column>
        <el-table-column label="操作" width="150">
          <template slot-scope="scope">
            <el-button size="mini" @click.stop="handleEdit(scope.row)">编辑</el-button>
            <el-popconfirm title="确认删除该公告吗？" @confirm="handleDelete(scope.row.id)">
              <el-button slot="reference" size="mini" type="danger" @click.stop>删除</el-button>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="30%">
      <el-form :model="form" :rules="rules" ref="form">
        <el-form-item label="文件名" prop="fileName">
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
  </div>
</template>

<script>
export default {
    name: 'Announcements',
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
    }
  },
  mounted() {
    this.loadData()
  },
  methods: {
    async loadData() {
      const res = await this.$http.get('/announcements', {
        params: { fileName: this.searchFileName }
      })
      this.tableData = res.data.data
    },
    handleSearch() {
      this.loadData()
    },
    handleAdd() {
      this.dialogTitle = '新增公告'
      this.form = {
        id: null,
        fileName: '',
        content: '',
        time: new Date().toISOString().slice(0, 10)
      }
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = '编辑公告'
      this.form = { ...row }
      this.dialogVisible = true
    },
    async submitForm() {
      this.$refs.form.validate(async valid => {
        if (valid) {
          const method = this.form.id ? 'put' : 'post'
          await this.$http[method]('/announcements', this.form)
          this.dialogVisible = false
          this.loadData()
        }
      })
    },
    async handleDelete(id) {
      await this.$http.delete(`/announcements/${id}`)
      this.loadData()
    },
    handleRowClick(row) {
      // 行点击处理
    }
  }
}
</script>

<style>
.indexGG {
  padding: 20px;
}
.header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}
.title {
  font-size: 17px;
  font-weight: bold;
  color: black;
}
</style>