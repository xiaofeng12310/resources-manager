<template>
  <div class="container">
    <!-- 普通员工视图 -->
    <template v-if="user.level === '员工'">
      <el-table :data="trainingList" border stripe>
        <el-table-column prop="name" label="培训名称"></el-table-column>
        <el-table-column prop="time" label="时间" width="180"></el-table-column>
        <el-table-column prop="location" label="地点"></el-table-column>
        <el-table-column label="操作" width="120">
          <template slot-scope="scope">
            <el-button
                type="primary"
                size="mini"
                @click="handleApply(scope.row)"
                :disabled="scope.row.applied"
            >{{ scope.row.applied ? '已报名' : '报名' }}</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 我的报名记录 -->
      <el-divider content-position="left">我的报名记录</el-divider>
      <el-table :data="myApplyList" border>
        <el-table-column prop="trainingName" label="培训项目"></el-table-column>
        <el-table-column prop="applyTime" label="报名时间" width="180" :formatter="formatTime"></el-table-column>
        <el-table-column label="状态" width="150">
          <template slot-scope="scope">
            <el-tag :type="getStatusType(scope.row.status)">
              {{ scope.row.status }}
            </el-tag>
            <el-button
                v-if="scope.row.status === '已报名'"
                type="danger"
                size="mini"
                @click="handleCancel(scope.row.id)"
                style="margin-left: 10px"
            >取消</el-button>
          </template>
        </el-table-column>
      </el-table>
    </template>

    <!-- 管理员视图 -->
    <template v-else-if="user.role === 'ADMIN' || user.level === '主管'">
      <el-table :data="allApplyList">
        <el-table-column prop="employeeName" label="员工姓名" />
        <el-table-column prop="trainingName" label="培训项目" />
        <el-table-column label="状态">
          <template slot-scope="scope">
            <el-select v-model="scope.row.status" @change="handleStatusChange(scope.row)">
              <el-option label="已报名" value="已报名" />
              <el-option label="已通过" value="已通过" />
              <el-option label="已拒绝" value="已拒绝" />
            </el-select>
          </template>
        </el-table-column>
      </el-table>
    </template>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || {}),
          trainingList: [],
        myApplyList: [],
        allApplyList: []
  }
  },
  methods: {
    getStatusType(status) {
      const statusMap = {
        '已报名': 'warning',
        '已通过': 'success',
        '已拒绝': 'danger',
        '已取消': 'info'
      };
      return statusMap[status] || 'info';
    },

    formatTime(row, column, cellValue) {
      if (!cellValue) return '无';
      const date = new Date(cellValue);
      return date.toLocaleString('zh-CN', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
      }).replace(/\//g, '-').replace(/,/g, '');
    },

    async loadTrainings() {
      try {
        const res = await this.$request.get('/training');
        this.trainingList = res.data.map(item => ({
          ...item,
          applied: false
        }));
        this.syncApplyStatus();
      } catch (error) {
        console.error('加载培训列表失败:', error);
      }
    },

    async loadMyApply() {
      try {
        const res = await this.$request.get('/training/apply/my');
        this.myApplyList = res.data || [];
        this.syncApplyStatus();
      } catch (error) {
        console.error('加载报名记录失败:', error);
      }
    },

    syncApplyStatus() {
      this.trainingList.forEach(training => {
        training.applied = this.myApplyList.some(
            apply => apply.trainingId === training.id
        );
      });
    },

    loadAllApply() {
      this.$request.get('/training/apply').then(res => {
        this.allApplyList = res.data;
      });
    },

    async handleApply(row) {
      try {
        await this.$request.post('/training/apply', {
          trainingId: row.id
        });
        this.$message.success('报名成功');
        await this.loadMyApply();
      } catch (error) {
        this.$message.error('报名失败: ' + (error.response?.data?.message || error.message));
      }
    },

    handleStatusChange(row) {
      this.$request.put('/training/apply', row).then(() => {
        this.$message.success('状态已更新');
      });
    },

    async handleCancel(id) {
      try {
        await this.$confirm('确认取消该报名？', '提示', { type: 'warning' });
        await this.$request.delete(`/training/apply/${id}`);
        this.$message.success('取消成功');
        await Promise.all([this.loadMyApply(), this.loadTrainings()]);
      } catch (error) {
        if (error !== 'cancel') {
          this.$message.error('取消失败: ' + (error.response?.data?.message || error.message));
        }
      }
    }
  },
  async mounted() {
    await this.loadTrainings();
    if (this.user.role === 'ADMIN' || this.user.level === '主管') {
      this.loadAllApply();
    } else {
      await this.loadMyApply();
    }
  }
}
</script>

<style scoped>
.el-divider {
  margin: 20px 0;
}
.el-table {
  margin-top: 10px;
}
</style>