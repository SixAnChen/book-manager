<script>
import request from "@/utils/request";

export default {
  name: "Register",
  data() {
    const validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入密码'));
      } else {
        if (this.form.checkPass !== '') {
          this.$refs.form.validateField('checkPass');
        }
        callback();
      }
    };
    const validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.form.password) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {
      form: {
        password: '',
        checkPass: ''
      },
      options: [
        {value: "用户"},
        {value: "职工"},
      ],
      rules: {
        password: [
          {validator: validatePass, trigger: 'blur'}
        ],
        checkPass: [
          {validator: validatePass2, trigger: 'blur'}
        ]
      }
    }
  },
  methods: {
    // 注册
    register() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          request.post("/user/register", this.form).then(res => {
            if (res.code === '200') {
              this.$message.success("注册成功")
              this.$router.push("/login");
            }else {
              this.$message.error(res.msg)
            }
          })
        }
      });
    }
  }
}
</script>

<template>
  <div class="container">
    <div class="form_box">
      <div class="title">
        欢迎注册图书管理系统
      </div>
      <el-form ref="form" :model="form" :rules="rules">
        <el-form-item>
          <el-input
              placeholder="请输入账号"
              prefix-icon="el-icon-user"
              v-model="form.name"
              clearable>
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
              prefix-icon="el-icon-lock"
              placeholder="请输入密码"
              v-model="form.password"
              show-password>
          </el-input>
        </el-form-item>
        <el-form-item prop="checkPass">
          <el-input
              prefix-icon="el-icon-lock"
              placeholder="请确认密码"
              v-model="form.checkPass"
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
      <el-button size="medium" @click="register()">注册</el-button>
      <div class="form_tie">
        <div style="flex: 1"></div>
        <div style="flex: 1;text-align: right;">
          已有账号？去
          <a href="/login" style="color: #0e838a">登录</a>
        </div>
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
  background-image: url("../assets/bg4.jpg");
  /* 背景大小 */
  background-size: cover;
  background-position: 50%;
  /* Flex 布局 */
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}

.form_box {
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

.form_tie {
  margin-top: 20px;
  display: flex;
  align-items: center;
  font-size: 14px;
}
</style>
