<template>
  <div class="manager-container">
    <!--  头部  -->
    <div class="manager-header">
      <div class="manager-header-left">
        <img src="@/assets/imgs/logo.png" />
        <div class="title">企通智汇人员管理系统</div>
      </div>

      <div class="manager-header-center">
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item :to="{ path: $route.path }">{{ $route.meta.name }}</el-breadcrumb-item>
        </el-breadcrumb>
      </div>

      <div class="manager-header-right">
        <el-dropdown placement="bottom">
          <div class="avatar">
            <img :src="user.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" />
            <div>{{ user.name ||  '' }}</div>
          </div>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="goToPerson">个人信息</el-dropdown-item>
            <el-dropdown-item @click.native="$router.push('/password')">修改密码</el-dropdown-item>
            <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>

    <!--  主体  -->
    <div class="manager-main">
      <!--  侧边栏  -->
      <div class="manager-main-left">
        <el-menu :default-openeds="['info', 'matters', 'user']" router style="border: none" :default-active="$route.path">
          <el-menu-item index="/home">
            <i class="el-icon-s-home"></i>
            <span slot="title">系统首页</span>
          </el-menu-item>
          <el-submenu index="info" v-if="user.role === 'ADMIN'">
            <template slot="title">
              <i class="el-icon-menu"></i><span>信息管理</span>
            </template>
            <el-menu-item index="/notice">公告信息</el-menu-item>
            <el-menu-item index="/department">部门信息</el-menu-item>
          </el-submenu>
          <el-submenu index="matters">
            <template slot="title">
              <i class="el-icon-menu"></i><span>人事管理</span>
            </template>
            <el-menu-item index="/salary">薪资信息</el-menu-item>
            <el-menu-item index="/financial" v-if="user.role === 'ADMIN'">财务支出</el-menu-item>
            <el-menu-item v-if="user.role === 'USER'" index="/askRecord">请假记录</el-menu-item>
            <el-menu-item v-if="user.role === 'ADMIN' || user.level === '主管'" index="/askApply">请假审批</el-menu-item>
            <el-menu-item index="/resources">资产信息</el-menu-item>
            <el-menu-item index="/resourcesApply">资产审批</el-menu-item>
            <el-menu-item index="/resourcesMy">员工资产</el-menu-item>
          </el-submenu>
          <el-submenu index="user" v-if="user.role === 'ADMIN'">
            <template slot="title">
              <i class="el-icon-menu"></i><span>用户管理</span>
            </template>
            <el-menu-item index="/admin">管理员信息</el-menu-item>
            <el-menu-item index="/user">员工信息</el-menu-item>
          </el-submenu>
          <el-submenu index="training">
            <template slot="title">
              <i class="el-icon-menu"></i><span>培训管理</span>
            </template>
            <el-menu-item
                v-if="user.role === 'ADMIN' || user.level === '主管'"
                index="/training"
            >培训项目</el-menu-item>
            <el-menu-item index="/trainingApply">培训报名</el-menu-item>
          </el-submenu>
        </el-menu>
      </div>

      <!--  数据表格  -->
      <div class="manager-main-right">
        <router-view @update:user="updateUser" />
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: "Manager",
  data() {
    return {
      user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
    }
  },
  created() {
    if (!this.user.id) {
      this.$router.push('/login')
    }
  },
  methods: {
    updateUser() {
      this.user = JSON.parse(localStorage.getItem('xm-user') || '{}')   // 重新获取下用户的最新信息
    },
    goToPerson() {
      if (this.user.role === 'ADMIN') {
        this.$router.push('/adminPerson')
      }
      if (this.user.role === 'USER') {
        this.$router.push('/employeePerson')
      }
    },
    logout() {
      localStorage.removeItem('xm-user')
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
@import "@/assets/css/manager.css";
</style>