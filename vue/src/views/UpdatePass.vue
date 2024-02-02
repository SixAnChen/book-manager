<script>
import request from "@/utils/request";

export default {
  name: "UpdatePass",
  data() {
    //校验新密码
    const validatePassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('确定新密码不能为空'))
      } else if (value !== this.user.newPassword) {
        callback(new Error('新密码必须一致'))
      } else {
        callback()
      }
    }
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      rules: {
        oldPassword: [
          {required: true, message: '旧密码不能为空！', trigger: 'blur'},
        ],
        newPassword: [
          {required: true, message: '新密码不能为空！', trigger: 'blur'},
        ],
        confirmPassword: [
          {required: true, message: '确认新密码不能为空！', trigger: 'blur'},
          {validator: validatePassword, required: true, trigger: 'blur'},
        ],
      }
    }
  },
  methods:{
    updatePass() {
      this.$refs.formRef.validate((valid) => {
        if (valid) {
          // 保存当前的用户信息到数据库
          request.put('/user/updatePass', this.user).then(res => {
            if (res.code === '200') {
              // 成功更新
              this.$message.success('保存成功')
              localStorage.removeItem("user")
              this.$router.push('/login')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
  }
}
</script>

<template>
  <div class="form">
    <el-form :model="user" ref="formRef" :rules="rules">
      <el-form-item label="旧密码" prop="oldPassword">
        <el-input size="medium" show-password v-model="user.oldPassword" placeholder="旧密码"></el-input>
      </el-form-item>
      <el-form-item label="新密码" prop="newPassword">
        <el-input size="medium" show-password v-model="user.newPassword" placeholder="新密码"></el-input>
      </el-form-item>
      <el-form-item label="确认新密码" prop="confirmPassword">
        <el-input size="medium" show-password v-model="user.confirmPassword" placeholder="确认新密码"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button size="medium" style="background: #505458; border: none"
                   type="primary" @click="updatePass">确定
        </el-button>
        <el-button size="medium" @click="$router.push('/')">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<style scoped>

/deep/ .el-form-item__label {
  font-weight: bold;
}

.form {
  text-align: center;
  width: 400px;
  box-shadow: 0 0 25px #cac6c6;
  overflow: hidden;
  padding: 40px;
}
</style>
