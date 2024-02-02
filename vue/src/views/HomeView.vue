<template>
  <div>
    <el-container style="min-height: 100vh">
      <el-aside :width="sideWidth + 'px'" style="box-shadow: 2px 0 6px rgb(0 21 41 / 35%)">
        <el-menu router :default-active="$route.path"
                 style="min-height: 100%; overflow-x: hidden;border-right: none"
                 background-color="rgb(43, 43, 43)"
                 text-color="#fff"
                 active-text-color="#ffd04b"
                 :collapse-transition="false"
                 :collapse="isCollapse">
          <div style="height: 60px; line-height: 60px; text-align: center;">
            <img src="../assets/logo.png" alt="" style="height: 40px; position: relative; top: 10px; right: 0px"/>
            <b style="color:white;margin-left: 10px; font-weight: bold; font-size: 20px;"
               v-show="logoTextShow">图书管理系统</b>
          </div>
          <el-menu-item index="/welcome">
            <i class="el-icon-s-home"></i>
            <span slot="title">系统首页</span>
          </el-menu-item>
          <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-success"></i>
              <span>管理员管理</span>
            </template>
            <el-menu-item index="/admin/adminview">
              <i class="el-icon-user-solid"></i>
              管理员信息
            </el-menu-item>
          </el-submenu>
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-s-flag"></i>
              <span>用户管理</span>
            </template>
            <el-menu-item index="/user/userview">
              <i class="el-icon-user-solid"></i>
              用户信息
            </el-menu-item>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-s-management"></i>
              <span>图书管理</span>
            </template>
            <el-menu-item index="/book/bookview">
              <i class="el-icon-tushu"></i>
              图书信息
            </el-menu-item>
            <el-menu-item index="/book/category">
              <i class="el-icon-tushu"></i>
              图书分类
            </el-menu-item>
            <el-menu-item index="/book/borrow">
              <i class="el-icon-tushu"></i>
              图书借阅
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>

      <el-container>
        <el-header style="
            background-color: rgb(43, 43, 43);
            color: white;
            line-height: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #ccc;
          ">
          <div style="width: 40px; font-size: 22px">
            <span
                :class="collapseBtnClass"
                style="cursor: pointer"
                @click="collapse">
            </span>
          </div>
          <div style="flex: 1">
            <breadcrumb></breadcrumb>
          </div>
          <el-dropdown style="margin-right: 10px; cursor: pointer;" placement="bottom">
            <div style="display:flex; align-items: center; justify-content: center">
              <el-avatar v-if="user.avatar" shape="square" :size="40"
                         style="border-radius: 10px"
                         :src="'http://localhost:9090/files/' + user.avatar">
              </el-avatar>
              <el-avatar v-else shape="square" :size="40"
                         style="border-radius: 10px"
                         src="https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png">
              </el-avatar>
            </div>
            <el-dropdown-menu slot="dropdown" style="margin-top: -4px">
              <el-dropdown-item @click.native="personal()">个人信息</el-dropdown-item>
              <el-dropdown-item @click.native="updatePass()">修改密码</el-dropdown-item>
              <el-dropdown-item @click.native="logout()">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-header>
        <el-main style="height: calc(100vh - 80px)">
          <router-view @update:user="updateUser"/>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import Breadcrumb from '../components/Breadcrumb.vue';

export default {
  name: "HomeView",
  components: {
    Breadcrumb,
  },
  data() {
    return {
      tableData: [],
      collapseBtnClass: "el-icon-s-fold",
      isCollapse: false,
      sideWidth: 200,
      logoTextShow: true,
      headerBg: "headerBg",
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    };
  },
  methods: {
    updateUser(user) {   // 获取子组件传过来的数据  更新当前页面的数据
      this.user = JSON.parse(JSON.stringify(user))  // 让父级的对象跟子级的对象毫无关联
    },
    logout() {
      localStorage.removeItem("user");
      this.$router.push("/login");
    },
    updatePass(){
      this.$router.push("/updatePass")
    },
    personal(){
      this.$router.push("/personal")
    },
    collapse() {
      // 点击收缩按钮触发
      this.isCollapse = !this.isCollapse;
      if (this.isCollapse) {
        // 收缩
        this.sideWidth = 64;
        this.collapseBtnClass = "el-icon-s-unfold";
        this.logoTextShow = false;
      } else {
        // 展开
        this.sideWidth = 200;
        this.collapseBtnClass = "el-icon-s-fold";
        this.logoTextShow = true;
      }
    },
  }
};
</script>
<style>
/* 一级菜单、二级菜单 中图和字体的距离 */
.el-menu-item i, .el-submenu__title i {
  margin-right: 20px !important;
}

/* 一级菜单、二级菜单 样式 */
.el-menu-item, .el-submenu__title {
  height: 50px !important;
  line-height: 50px !important;
}

/* 一级菜单、二级菜单 鼠标悬浮时，图标的颜色 */
.el-menu-item:hover i {
  color: #fff !important;
}

/*.el-submenu__title:hover i{
  color: #fff !important;
}*/


/* 一级菜单、二级菜单 鼠标悬浮 样式 */
.el-menu-item:hover {
  background: rgba(0, 0, 0, 0.65) !important;
  color: #fff !important;
  border-radius: 10px !important;
}

.el-submenu__title:hover {
  background: rgb(43, 43, 43) !important;
}


/*一级菜单 处于激活状态下的样式 */
.el-menu-item.is-active {
  background: rgba(0, 0, 0, 0.65) !important;
  color: #fff !important;
  border-radius: 10px !important;
}

.el-dropdown {
  color: white !important;
}

.el-breadcrumb__inner a, .el-breadcrumb__item span {
  color: white !important;
}
</style>

