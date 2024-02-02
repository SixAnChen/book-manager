<script>
import request from "@/utils/request";

export default {
  name: "forgetPass",
  data() {
    return {
      form: {},
    }
  },
  methods: {
    resetPassword() {
      request.put('/user/resetPass', this.form).then(res => {
        if (res.code === '200') {
          this.$message.success('重置成功')
          this.$router.push('/login')
        } else {
          this.$message.error(res.msg)
        }
      })
    },
  }
}
</script>

<template>
  <div class="container">
    <div class="box">
      <div class="title">
        重置密码
      </div>
      <el-form :model="form">
        <el-form-item>
          <el-input
              placeholder="请输入账号"
              prefix-icon="el-icon-user-solid"
              v-model="form.name"
              clearable>
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-input
              placeholder="请输入手机号"
              prefix-icon="el-icon-phone"
              v-model="form.phone"
              clearable>
          </el-input>
        </el-form-item>
      </el-form>
      <div style="display: flex; justify-content: center">
        <el-button @click="resetPassword" type="primary">重置</el-button>
        <el-button @click="$router.push('/login')">取消</el-button>
      </div>
    </div>
  </div>
</template>

<style scoped>

.container {
  /* 高度 */
  height: 100vh;
  /* 超出隐藏 */
  overflow: hidden;
  /* 背景图片 */
  background-image: url("../assets/bg3.jpg");
  /* 背景大小 */
  background-size: cover;
  background-position: 50%;
  /* Flex 布局 */
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}

.box {
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
</style>
