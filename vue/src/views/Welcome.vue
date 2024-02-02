<template>
  <div>
    <el-col :span="24">
      <el-card>
         您好，{{ user.name }} 先生 🧛， 欢迎使用图书管理系统！
      </el-card>
    </el-col>

    <el-col :span="12">
      <el-card style="margin-top: 10px">
        <div slot="header">
          <span>Button 按钮</span>
        </div>
        <el-button>默认按钮</el-button>
        <el-button type="primary">主要按钮</el-button>
        <el-button type="success">成功按钮</el-button>
        <el-button type="info">信息按钮</el-button>
        <el-button type="warning">警告按钮</el-button>
        <el-button type="danger">危险按钮</el-button>
      </el-card>
    </el-col>

  </div>
</template>

<script>
export default {
  name: "Welcome",
  data() {
    return {
      user: {
        name: "admin"
      }
    }
  }
}
</script>

<style scoped>
* {
  font-size: 14px;
}
</style>
