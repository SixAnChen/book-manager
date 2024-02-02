<template>
  <div class="container">
    <div class="login_box">
      <div class="title">
        欢迎登录图书管理系统
      </div>
      <el-form ref="form" :model="form">
        <el-form-item>
          <el-input
              placeholder="请输入账号"
              prefix-icon="el-icon-user"
              v-model="form.name"
              clearable>
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-input
              prefix-icon="el-icon-lock"
              placeholder="请输入密码"
              v-model="form.password"
              show-password>
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-select v-model="form.role" clearable placeholder="请选择您的角色" style="width: 100%">
            <el-option
                v-for="item in options"
                :key="item.index"
                :label="item.value"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <el-button size="medium" @click="login()">登录</el-button>
      <div class="login_tie">
        <div style="flex: 1">
          <a href="/forgetPass" style="text-decoration: none; color: #0e838a">忘记密码</a>
        </div>
        <div style="flex: 1;text-align: right;">
          还没有账号？去
          <a href="/register" style="text-decoration: none;color: #0e838a">注册</a>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import request from "@/utils/request";

export default {
  name: "Login",
  data() {
    return {
      form: {},
      options: [
        {value: "管理员"},
        {value: "用户"},
        {value: "职工"},
      ],
    }
  },
  methods: {
    // 登录
    login() {
      request.post("/user/login", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("登录成功")
          localStorage.setItem("user", JSON.stringify(res.data))
          this.$router.push("/");
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>
<style scoped>
.container {
  /* 高度 */
  height: 100vh;
  /* 超出隐藏 */
  overflow: hidden;
  /* 背景图片 */
  background-image: url("../assets/bg1.jpg");
  /* 背景大小 */
  background-size: cover;
  background-position: 50%;
  /* Flex 布局 */
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}

.login_box {
  /* 宽度 */
  width: 400px;
  /* 内边距 */
  padding: 30px;
  /* 背景颜色 */
  background-color: white;
  /* 边框弯曲度 */
  border-radius: 5px;
}

.title {
  text-align: center;
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 20px;
}

.el-button {
  width: 100%;
  background-color: rgb(96, 143, 222);
  border-color: rgb(96, 143, 222);
  color: white;
}

.login_tie {
  margin-top: 20px;
  display: flex;
  align-items: center;
  font-size: 14px;
}
</style>
