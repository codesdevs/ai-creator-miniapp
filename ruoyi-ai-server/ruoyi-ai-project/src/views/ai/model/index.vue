<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="模型名称" prop="modelName">
        <el-input
          v-model="queryParams.modelName"
          placeholder="请输入模型名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型编码" prop="modelCode">
        <el-input
          v-model="queryParams.modelCode"
          placeholder="请输入模型编码"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型类型" prop="modelType">
        <el-select v-model="queryParams.modelType" placeholder="请选择模型类型" clearable style="width: 200px">
          <el-option label="文本" value="TEXT" />
          <el-option label="图片" value="IMAGE" />
          <el-option label="视频" value="VIDEO" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 200px">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:model:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['ai:model:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['ai:model:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="modelList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="modelId" width="80" />
      <el-table-column label="模型名称" align="center" prop="modelName" min-width="140" />
      <el-table-column label="模型编码" align="center" prop="modelCode" min-width="140" />
      <el-table-column label="类型" align="center" prop="modelType" width="90" />
      <el-table-column label="服务商" align="center" prop="provider" min-width="120" />
      <el-table-column label="排序" align="center" prop="sort" width="80" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'info'">
            {{ scope.row.status === '0' ? '正常' : '停用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ai:model:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:model:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="title" v-model="open" width="720px" append-to-body>
      <el-form ref="modelRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="模型名称" prop="modelName">
              <el-input v-model="form.modelName" placeholder="请输入模型名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="模型编码" prop="modelCode">
              <el-input v-model="form.modelCode" placeholder="请输入模型编码" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="模型类型" prop="modelType">
              <el-select v-model="form.modelType" placeholder="请选择模型类型">
                <el-option label="文本" value="TEXT" />
                <el-option label="图片" value="IMAGE" />
                <el-option label="视频" value="VIDEO" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="服务商" prop="provider">
              <el-input v-model="form.provider" placeholder="请输入服务商" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="排序" prop="sort">
              <el-input-number v-model="form.sort" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio value="0">正常</el-radio>
                <el-radio value="1">停用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="封面地址" prop="coverUrl">
              <el-input v-model="form.coverUrl" placeholder="请输入封面地址" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="模型简介" prop="intro">
              <el-input v-model="form.intro" type="textarea" :rows="3" placeholder="请输入模型简介" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiModel">
import { addModel, delModel, getModel, listModel, updateModel } from "@/api/ai/model"

const { proxy } = getCurrentInstance()

const modelList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    modelName: undefined,
    modelCode: undefined,
    modelType: undefined,
    status: undefined
  },
  rules: {
    modelName: [{ required: true, message: "模型名称不能为空", trigger: "blur" }],
    modelCode: [{ required: true, message: "模型编码不能为空", trigger: "blur" }],
    modelType: [{ required: true, message: "模型类型不能为空", trigger: "change" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listModel(queryParams.value).then(response => {
    modelList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    modelId: undefined,
    modelName: undefined,
    modelCode: undefined,
    modelType: "IMAGE",
    provider: undefined,
    coverUrl: undefined,
    intro: undefined,
    sort: 0,
    status: "0",
    remark: undefined
  }
  proxy.resetForm("modelRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.modelId)
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加模型"
}

function handleUpdate(row) {
  reset()
  const modelId = row.modelId || ids.value[0]
  getModel(modelId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改模型"
  })
}

function submitForm() {
  proxy.$refs["modelRef"].validate(valid => {
    if (valid) {
      const request = form.value.modelId ? updateModel(form.value) : addModel(form.value)
      request.then(() => {
        proxy.$modal.msgSuccess(form.value.modelId ? "修改成功" : "新增成功")
        open.value = false
        getList()
      })
    }
  })
}

function handleDelete(row) {
  const modelIds = row.modelId || ids.value
  proxy.$modal.confirm('是否确认删除模型编号为"' + modelIds + '"的数据项？').then(function() {
    return delModel(modelIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
</script>
