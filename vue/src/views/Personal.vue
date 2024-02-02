<script>
import request from "@/utils/request";
import {pcaTextArr} from 'element-china-area-data'
export default {
  name: "Personal",
  data() {
    return {
      pcaTextArr,
      selectedOptions: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.selectedOptions = this.user.address.split("/")
  },
  methods: {
    //地址选择 数组转字符串
    handleChange(value) {
      this.user.address = JSON.parse(JSON.stringify(value)).join('/');
    },
    handleAvatarSuccess(res) {
      this.user.avatar = res.data
    },
    update() {
      // 保存当前的用户信息到数据库
      request.put('/user/update', this.user).then(res => {
        if (res.code === '200') {
          // 成功更新
          this.$message.success('保存成功')
          // 更新浏览器缓存里的用户信息
          localStorage.setItem('user', JSON.stringify(this.user))
          // 触发父级的数据更新
          this.$emit('update:user', this.user)
        } else {
          this.$message.error(res.msg)
        }
      })
    },
  }
}
</script>

<template>
  <div class="form">
    <el-form :model="user">
      <el-form-item style="display:flex;align-items: center;justify-content: center">
        <el-upload
            class="avatar-uploader"
            action="http://localhost:9090/files/upload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
        >
          <img v-if="user.avatar" :src="'http://localhost:9090/files/' + user.avatar" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </el-form-item>
      <el-form-item prop="username">
        <el-input v-model="user.name" size="medium" prefix-icon="el-icon-user"
                  placeholder="用户名"></el-input>
      </el-form-item>
      <el-form-item prop="address">
        <el-cascader
            style="width: 100%"
            clearable
            placeholder="请输入地址"
            v-model="selectedOptions"
            :options="pcaTextArr"
            :props="{ expandTrigger: 'hover' }"
            @change="handleChange">
        </el-cascader>
      </el-form-item>
      <el-form-item prop="email">
        <el-input v-model="user.email" size="medium" prefix-icon="el-icon-message"
                  placeholder="邮箱"></el-input>
      </el-form-item>
      <el-form-item prop="phone">
        <el-input v-model="user.phone" size="medium" prefix-icon="el-icon-phone"
                  placeholder="电话"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button size="medium" style="background: #505458; border: none"
                   type="primary" @click="update()">修改
        </el-button>
        <el-button size="medium" @click="$router.push('/')">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<style scoped>
.form {
  text-align: center;
  width: 500px;
  box-shadow: 0 0 25px #cac6c6;
  padding: 40px;
}

.avatar-uploader {
  width: 100px;
  height: 100px;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
}

.avatar {
  width: 100px;
  height: 100px;
  display: block;
}
</style>
