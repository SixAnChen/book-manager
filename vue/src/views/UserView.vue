<template>
  <div>
    <el-card>
      <el-input size="medium" v-model="params.name" style="width: 200px" placeholder="请输入姓名"></el-input>
      <el-input size="medium" v-model="params.address" style="width: 200px;margin-left: 10px"
                placeholder="请输入地址"></el-input>
      <el-button type="primary" style="margin-left: 10px" @click="load">查询</el-button>
      <el-button type="warning" style="margin-left: 10px" @click="reset">重置</el-button>
      <el-button type="success" style="margin-left: 10px" @click="save()">新增</el-button>
      <el-button
          type="danger"
          style="margin-left: 10px;"
          @click="delBatch">
        批量删除
      </el-button>
    </el-card>
    <el-card style="margin-top: 10px">
      <el-table
          border
          :data="tableData"
          :cell-style="{'text-align':'center'}"
          :header-cell-style="{'text-align':'center'}"
          @selection-change="handleSelectionChange"
          ref="multipleTable"
          row-key="id"
          style="width: 100%">
        <el-table-column type="selection" width="55" :reserve-selection="true"/>
        <el-table-column label="头像" align="center" width="80">
          <template v-slot="scope">
            <el-image
                v-if="scope.row.avatar"
                style="height: 40px; width: 40px; border-radius: 50%"
                :src="'http://localhost:9090/files/' + scope.row.avatar"
                :preview-src-list="['http://localhost:9090/files/' + scope.row.avatar]">
            </el-image>
            <el-image
                v-else
                style="height: 40px; width: 40px; border-radius: 50%"
                src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png">
            </el-image>
          </template>
        </el-table-column>
        <el-table-column
            prop="name"
            label="姓名"
            width="100">
        </el-table-column>
        <el-table-column
            label="出生日期"
            width="140">
          <template slot-scope="scope">
            <el-tag>
              <i class="el-icon-time"></i>
              <span style="margin-left: 10px">{{ scope.row.birthday }}</span>
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column
            prop="address"
            label="地址"
            show-overflow-tooltip
            width="120">
        </el-table-column>
        <el-table-column label="状态" width="100">
          <template slot-scope="scope">
            <el-switch
                v-model="scope.row.status"
                @change="changeStatus(scope.row)"
                active-color="#13ce66"
                inactive-color="#ff4949">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column
            label="角色"
            width="100">
          <template slot-scope="scope">
            <el-tag :type="handleType(scope.row.role)">
              {{ scope.row.role }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column
            label="评分"
            width="180">
          <template slot-scope="scope">
            <el-rate
                v-model="scope.row.score"
                disabled
                :colors="colors">
            </el-rate>
          </template>
        </el-table-column>
        <el-table-column
            prop="email"
            label="邮箱"
            width="160">
        </el-table-column>
        <el-table-column label="操作" align="center" width="180" fixed="right">
          <template slot-scope="scope">
            <el-button
                icon="el-icon-edit"
                @click="handleEdit(scope.row)">编辑
            </el-button>
            <el-button
                icon="el-icon-delete"
                type="danger"
                @click="handleDelete(scope.row.id)">删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <el-card style="margin-top: 10px">
      <el-pagination
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="params.pageNum"
          :page-size="params.pageSize"
          :page-sizes="[10, 20, 30, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </el-card>
    <el-dialog title="用户信息" :visible.sync="dialogFormVisible" width="35%" @close="handleCancel">
      <el-form :model="form" label-width="20%" :rules="rules" ref="form">
        <el-form-item label="头像">
          <el-upload action="http://localhost:9090/files/upload"
                     list-type="picture"
                     :file-list="fileList"
                     :on-success="successUpload"
                     :before-upload="beforeAvatarUpload"
                     style="width: 90%">
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
        </el-form-item>
        <el-form-item label="出生日期" prop="birthday">
          <el-date-picker v-model="form.birthday" type="date"
                          value-format="yyyy-MM-dd"
                          style="width: 90%">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-cascader
              style="width: 90%"
              clearable
              v-model="selectedOptions"
              :options="pcaTextArr"
              :props="{ expandTrigger: 'hover' }"
              @change="handleChange">
          </el-cascader>
        </el-form-item>
        <el-form-item label="角色" prop="role">
          <el-select v-model="form.role" style="width: 90%">
            <el-option
                v-for="item in options"
                :key="item.index"
                :label="item.value"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="评分">
          <el-rate
              style="margin-top: 8px; margin-left: 10px"
              v-model="form.score"
              :colors="colors">
          </el-rate>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import request from "@/utils/request";
import {pcaTextArr} from 'element-china-area-data'

export default {
  name: "UserView",
  data() {
    return {
      pcaTextArr,
      selectedOptions: [],
      tableData: [],
      total: 0,
      params: {
        pageNum: 1,
        pageSize: 10,
        name: '',
        address: ''
      },
      form: {},
      dialogFormVisible: false,
      rules: {
        name: [
          {required: true, message: '请输入姓名', trigger: 'blur'},
        ],
        address: [
          {required: true, message: '请输入选择地址', trigger: 'blur'},
        ]
      },
      fileList: [],
      ids: [],

      options: [
        {value: '管理员'},
        {value: '职工'},
        {value: '用户'}
      ],

      colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      request.get('/user/search', {params: this.params}).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },
    handleSizeChange(pageSize) {
      this.params.pageSize = pageSize;
      this.load();
    },
    handleCurrentChange(pageNum) {
      this.params.pageNum = pageNum;
      this.load();
    },
    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 10,
        name: '',
        address: ''
      }
      this.load()
    },
    save() {
      this.form = {};
      this.dialogFormVisible = true;
      this.selectedOptions = []
    },
    handleEdit(obj) {
      this.form = JSON.parse(JSON.stringify(obj)); //深拷贝
      this.dialogFormVisible = true;
      this.selectedOptions = this.form.address.split("/")
    },
    handleDelete(id) {
      this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        request.delete("/user/delete/" + id).then(res => {
          if (res.code === '200') {
            this.load();
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
        this.$message.info("已取消删除")
      });
    },
    handleCancel() {
      this.$refs.form.resetFields();
    },
    submit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          request({
            url: this.form.id ? '/user/update' : '/user/add',
            method: this.form.id ? 'PUT' : 'POST',
            data: this.form,
          }).then(res => {
            if (res.code === '200') {
              this.$message.success("操作成功")
              this.dialogFormVisible = false
              this.fileList = []
              this.load()
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },

    successUpload(res) {
      this.form.avatar = res.data;
    },

    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 / 10 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 20MB!');
      }
      return isJPG && isLt2M;
    },
    handleSelectionChange(rows) {
      this.ids = rows.map(item => item.id)
    },
    delBatch() {
      if (this.ids.length === 0) {
        this.$message.info("请选择要删除的数据")
        return
      }
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        request.delete("/user/delete/batch", {data: this.ids}).then(res => {
          if (res.code === '200') {
            this.$message.success("删除成功")
            this.$refs.multipleTable.clearSelection()
            this.load()
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },

    //地址选择 数组转字符串
    handleChange(value) {
      this.form.address = JSON.parse(JSON.stringify(value)).join('/');
    },


    changeStatus(row) {
      if (this.user.id === row.id && !row.status) {
        row.status = true
        this.$notify.warning("您的操作不合法")
        return
      }
      request.put("/user/update", row).then(res => {
        if (res.code === '200') {
          this.$notify.success("状态修改成功")
          this.load();
        } else {
          this.$notify.error(res.msg)
        }
      })
    },

    handleType(role) {
      if (role === "用户") {
        return "success";
      } else if (role === "管理员") {
        return "danger"
      } else if (role === "职工") {
        return "warning"
      } else {
        return "info"
      }
    }
  }
}
</script>
