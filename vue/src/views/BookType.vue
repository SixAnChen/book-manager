<script>
import request from "@/utils/request";

export default {
  name: "BookType",
  data() {
    return {
      params: {
        pageNum: 1,
        pageSize: 10,
        name: ''
      },
      tableData: [],
      total: 0,
      form: {},
      dialogFormVisible: false,
      typeObjs: [],
      icons: [
        {
          name: 'thumbs',
          value: 'icon icon-thumbs-up'
        },
        {
          name: 'grid',
          value: 'icon icon-grid'
        },
        {
          name: 'bookmark',
          value: 'icon icon-bookmark'
        },
        {
          name: 'battery',
          value: 'icon icon-battery-charging'
        },
        {
          name: 'activity',
          value:'icon icon-activity'
        },
        {
          name:'award',
          value: 'icon icon-award'
        },

      ]
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
    // 初始化表格数据
    load() {
      request.get('/type/search', {params: this.params}).then(res => {
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
    // 重置
    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 10,
        name: ''
      }
      this.load()
    },
    // 新增
    handleAdd() {
      this.form = {};
      this.dialogFormVisible = true;
    },
    // 编辑
    handleEdit(obj) {
      this.form = JSON.parse(JSON.stringify(obj)); //深拷贝
      this.dialogFormVisible = true;
    },
    // 表单提交
    submit() {
      request({
        url: this.form.id ? '/type/update' : '/type/add',
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
    // 删除
    handleDelete(id) {
      this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        request.delete("/type/delete/" + id).then(res => {
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
    // 关闭弹窗，清空表单
    handleCancel() {
      this.$refs.form.resetFields();
    }
  }
}
</script>

<template>
  <div>
    <el-card>
<!--      <el-select v-model="params.name">
        <el-option
            v-for="item in typeObjs"
            :key="item.index"
            :label="item.name"
            :value="item.name">
        </el-option>
      </el-select>-->
      <el-input size="medium" v-model="params.name" style="width: 200px" placeholder="请输入分类关键字"></el-input>
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
        <el-table-column
            label="#"
            width="100">
          <template scope="scope">
            <span>{{ (params.pageNum - 1) * params.pageSize + scope.$index + 1 }}</span>
          </template>
        </el-table-column>
        <el-table-column
            prop="name"
            label="分类名称"
            width="200"
            show-overflow-tooltip>
        </el-table-column>
        <el-table-column
            prop="description"
            label="分类描述"
            width="200"
            show-overflow-tooltip>
        </el-table-column>
        <el-table-column
            label="分类图标"
            width="100">
          <template slot-scope="scope">
            <i :class="scope.row.icon" style="font-size: 20px"></i>
          </template>
        </el-table-column>
        <el-table-column
            prop="url"
            label="分类链接">
          <template slot-scope="scope">
            <a :href="scope.row.url" target="_blank">{{scope.row.url}}</a>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="180">
          <template slot-scope="scope">
            <el-button
                @click="handleEdit(scope.row)">编辑
            </el-button>
            <el-button
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
          :page-sizes="[10, 20, 25, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </el-card>

    <el-dialog title="图书分类信息" :visible.sync="dialogFormVisible" width="35%" @close="handleCancel">
      <el-form :model="form" label-width="20%" ref="form">
        <el-form-item label="分类名称" prop="name">
          <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
        </el-form-item>
        <el-form-item label="分类描述" prop="description">
          <el-input type="textarea" :autosize="{ minRows: 1, maxRows:10 }" v-model="form.description" autocomplete="off"
                    style="width: 90%"></el-input>
        </el-form-item>
        <el-form-item label="分类图标" prop="icon">
          <el-select v-model="form.icon" style="width: 90%">
            <el-option
                v-for="item in icons"
                :key="item.index"
                :label="item.name"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="分类链接" prop="url">
          <el-input v-model="form.url" autocomplete="off" style="width: 90%"></el-input>
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
