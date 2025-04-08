<template>
  <div class="container">
    <!-- 搜索栏 -->
    <div class="search">
      <el-input v-model="searchName" placeholder="输入培训名称" style="width: 200px"></el-input>
      <el-button type="primary" @click="loadData">搜索</el-button>
    </div>

    <!-- 操作按钮 -->
    <div class="operation">
      <el-button type="primary" @click="dialogVisible = true">新增培训</el-button>
      <el-button type="danger" @click="batchDelete">批量删除</el-button>
    </div>

    <!-- 数据表格 -->
    <el-table
        :data="tableData"
        @selection-change="handleSelectionChange"
        border
        stripe
    >
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="name" label="培训名称"></el-table-column>
      <el-table-column prop="time" label="时间" width="180"></el-table-column>
      <el-table-column prop="location" label="地点"></el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope">
          <el-button type="text" @click="edit(scope.row)">编辑</el-button>
          <el-button type="text" @click="del(scope.row.id)" style="color: #F56C6C">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
        @current-change="handlePageChange"
        :current-page="pageNum"
        :page-size="pageSize"
        layout="total, prev, pager, next"
        :total="total"
    ></el-pagination>

    <!-- 新增/编辑对话框 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="40%">
      <el-form :model="form" label-width="80px" :rules="rules" ref="form">
        <el-form-item label="培训名称" prop="name">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="培训内容">
          <el-input type="textarea" v-model="form.content" rows="4"></el-input>
        </el-form-item>
        <el-form-item label="培训时间">
          <el-date-picker
              v-model="form.time"
              type="datetime"
              placeholder="选择日期时间"
              value-format="yyyy-MM-dd HH:mm:ss"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="培训地点">
          <el-input v-model="form.location"></el-input>
        </el-form-item>
        <el-form-item label="负责人">
          <el-input v-model="form.teacher"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      searchName: '',
      dialogVisible: false,
      dialogTitle: '新增培训',
      form: {},
      rules: {
        name: [{ required: true, message: '请输入培训名称', trigger: 'blur' }]
      },
      multipleSelection: []
    }
  },
  methods: {
    loadData() {
      this.$request.get('/training')
          .then(res => {
            this.tableData = res.data; // 确保赋值到正确的响应数据字段
            console.log('Loaded data:', this.tableData); // 调试日志
          });
    },
    handlePageChange(pageNum) {
      this.pageNum = pageNum
      this.loadData()
    },
    handleSelectionChange(val) {
      this.multipleSelection = val.map(item => item.id)
    },
    add() {
      this.dialogTitle = '新增培训'
      this.form = {}
      this.dialogVisible = true
    },
    edit(row) {
      this.dialogTitle = '编辑培训'
      this.form = { ...row }
      this.dialogVisible = true
    },
    save() {
      this.$refs.form.validate(valid => {
        if (!valid) return;

        // 统一使用POST，后端用@PostMapping接收
        this.$request.post('/training', this.form)
            .then(() => {
              this.$message.success('保存成功');
              this.dialogVisible = false;
              this.form = {}; // 清空表单
              this.loadData();
            })
            .catch(error => {
              console.error('Error:', error);
            });
      });
    },
    del(id) {
      this.$confirm('确认删除该培训项目？', '提示', { type: 'warning' })
          .then(() => {
            this.$request.delete(`/training/${id}`)
                .then(() => {
                  this.$message.success('删除成功')
                  this.loadData()
                })
          })
    },
    batchDelete() {
      if (this.multipleSelection.length === 0) {
        return this.$message.warning('请选择要删除的数据')
      }
      this.$confirm('确认批量删除选中的培训项目？', '提示', { type: 'warning' })
          .then(() => {
            this.$request.post('/training/delete/batch', this.multipleSelection)
                .then(() => {
                  this.$message.success('批量删除成功')
                  this.loadData()
                })
          })
    }
  },
  created() {
    this.loadData()
  }
}
</script>

<style scoped>
/* 保持与原有样式一致 */
.operation {
  margin: 10px 0;
}
.el-pagination {
  margin-top: 15px;
}
</style>