<script>
import request from "@/utils/request";

export default {
  name: "BookBorrow",
  data() {
    return {
      params: {
        pageNum: 1,
        pageSize: 10,
      },
      tableData: [],
      total: 0,

      form: {},
      dialogFormVisible: false,
    }
  },
  created() {
    this.load()
  },
  methods: {
    handleSizeChange(pageSize) {
      this.params.pageSize = pageSize;
      this.load();
    },
    handleCurrentChange(pageNum) {
      this.params.pageNum = pageNum;
      this.load();
    },

    load() {
      request.get('/reserve/search', {params: this.params}).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },
    handleCancel() {
      this.$refs.form.resetFields();
    },
    audit(obj) {
      this.form = JSON.parse(JSON.stringify(obj)); //深拷贝
      this.dialogFormVisible = true;
    },
    submit() {
      request.put("/reserve/update", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("操作成功")
          this.dialogFormVisible = false;
          this.load();
        } else {
          this.$message.error(res.msg)
        }
      })
    },
  }
}
</script>

<template>
  <div>
    <el-card style="margin-top: 10px">
      <el-table
          border
          :data="tableData"
          :cell-style="{'text-align':'center'}"
          :header-cell-style="{'text-align':'center'}"
          style="width: 100%">
        <el-table-column prop="bookName" label="图书名称"></el-table-column>
        <el-table-column prop="userName" label="借阅用户"></el-table-column>
        <el-table-column prop="time" label="借阅时间"></el-table-column>
        <el-table-column prop="status" label="审核状态"></el-table-column>
        <el-table-column prop="reason" label="审核意见"></el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
                icon="el-icon-edit"
                type="text"
                @click="audit(scope.row)">审核
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
        <el-form-item label="审核状态">
          <el-radio v-model="form.status" label="审核通过"></el-radio>
          <el-radio v-model="form.status" label="审核不通过" style="margin-left: 30px"></el-radio>
        </el-form-item>
        <el-form-item label="审核意见">
          <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 4}" v-model="form.reason" autocomplete="off" style="width: 90%"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped>

</style>
