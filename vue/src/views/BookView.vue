<script>
import request from "@/utils/request";

export default {
  name: "BookView",
  data() {
    return {
      params: {
        pageNum: 1,
        pageSize: 20,
        name: '',
        author: ''
      },
      tableData: [],
      total: 0,
      form: {},
      dialogFormVisible: false,
      fileList: [],
      options: [
        {value: '清华出版社'},
        {value: '中国人民教育出版社'},
        {value: '机械工业出版社'},
        {value: '人民邮电出版社'},
        {value: '中华书局'},
      ],
      typeObjs: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load()
    this.findType()
  },
  methods: {
    findType() {
      request.get("/type").then(res => {
        if (res.code === '200') {
          this.typeObjs = res.data
        } else {
          this.$message.error(res.msg)
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
    load() {
      request.get('/book/search', {params: this.params}).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },
    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 20,
        name: '',
        author: ''
      }
      this.load()
    },
    // 新增
    handleAdd() {
      this.form = {};
      this.dialogFormVisible = true;
    },

    handleEdit(obj) {
      this.form = JSON.parse(JSON.stringify(obj)); //深拷贝
      this.dialogFormVisible = true;
    },
    handleDelete(id) {
      this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        request.delete("/book/delete/" + id).then(res => {
          if (res.code === '200') {
            this.load();
            this.$message.success("删除成功")
          } else {
            this.$message.error(res.msg)
          }
        })
      }).catch(() => {
        this.$message.info("已取消删除")
      });
    },

    // 上传图片成功
    successUpload(res) {
      this.form.cover = res.data;
    },
    handleCancel() {
      this.$refs.form.resetFields();
    },
    submit() {
      request({
        url: this.form.id ? '/book/update' : '/book/add',
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
    },

    reserve(row){
      let param = {bookId: row.id, userId: this.user.id}
      request.post("/reserve", param).then(res => {
        if (res.code === '200') {
          this.$message.success("借阅成功")
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>
<template>
  <div>
    <el-card>
      <el-input size="medium" v-model="params.name" style="width: 200px" placeholder="请输入图书名称"></el-input>
      <el-input size="medium" v-model="params.author" style="width: 200px; margin-left: 10px"
                placeholder="请输入图书作者"></el-input>
      <el-button type="primary" style="margin-left: 10px" @click="load">查询</el-button>
      <el-button type="warning" style="margin-left: 10px" @click="reset">重置</el-button>
      <el-button type="success" style="margin-left: 10px" @click="handleAdd()">新增</el-button>
    </el-card>
    <el-card style="margin-top: 10px">
      <el-table
          border
          :data="tableData"
          :cell-style="{'text-align':'center'}"
          :header-cell-style="{'text-align':'center'}"
          style="width: 100%">
        <el-table-column label="图书封面" align="center" width="120">
          <template v-slot="scope">
            <el-image
                style="height: 40px; width: 40px; border-radius: 50%"
                :src="'http://localhost:9090/files/' + scope.row.cover"
                :preview-src-list="['http://localhost:9090/files/' + scope.row.cover]">
            </el-image>
          </template>
        </el-table-column>
        <el-table-column
            prop="isbn"
            label="ISBN码"
            width="120">
        </el-table-column>
        <el-table-column
            prop="name"
            label="图书名称"
            width="120">
        </el-table-column>
        <el-table-column
            prop="author"
            label="图书作者"
            width="120">
        </el-table-column>
        <el-table-column
            prop="publisher"
            label="图书出版社"
            show-overflow-tooltip
            width="120">
        </el-table-column>
        <el-table-column
            prop="publishTime"
            label="出版年份"
            width="120">
        </el-table-column>
        <el-table-column
            prop="price"
            label="图书价格"
            width="120">
        </el-table-column>
        <el-table-column
            prop="num"
            label="剩余本数"
            width="120">
        </el-table-column>
        <el-table-column
            prop="typeName"
            label="图书分类"
            width="120">
        </el-table-column>
        <el-table-column
            prop="summary"
            label="图书简介"
            show-overflow-tooltip>
        </el-table-column>
        <el-table-column label="操作" align="center" width="300" fixed="right">
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
            <el-button
                icon="el-icon-star-on"
                type="primary"
                @click="reserve(scope.row)">借阅
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
          :page-sizes="[5, 10, 20, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </el-card>
    <el-dialog title="图书信息" :visible.sync="dialogFormVisible" width="35%" @close="handleCancel">
      <el-form :model="form" label-width="20%" ref="form">
        <el-form-item label="图书封面">
          <el-upload action="http://localhost:9090/files/upload"
                     list-type="picture"
                     :file-list="fileList"
                     :on-success="successUpload"
                     style="width: 90%">
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="图书名称" prop="name">
          <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
        </el-form-item>
        <el-form-item label="图书作者" prop="author">
          <el-input v-model="form.author" autocomplete="off" style="width: 90%"></el-input>
        </el-form-item>
        <el-form-item label="图书出版社" prop="publisher">
          <el-select v-model="form.publisher" style="width: 90%">
            <el-option
                v-for="item in options"
                :key="item.index"
                :label="item.value"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="出版年份" prop="publishTime">
          <el-date-picker
              style="width: 90%;"
              v-model="form.publishTime"
              type="year"
              value-format="yyyy"
              placeholder="选择年份">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="图书分类">
          <el-select v-model="form.typeId" style="width: 90%">
            <el-option
                v-for="item in typeObjs"
                :key="item.id"
                :label="item.name"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="图书价格" prop="price">
          <el-input v-model="form.price" autocomplete="off" style="width: 90%"></el-input>
        </el-form-item>
        <el-form-item label="图书简介" prop="summary">
          <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 3}" v-model="form.summary" autocomplete="off"
                    style="width: 90%"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<style>
.el-tooltip__popper {
  max-width: 300px;
}
</style>
