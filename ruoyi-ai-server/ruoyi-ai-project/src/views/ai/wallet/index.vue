<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="用户ID" prop="userId">
        <el-input-number v-model="queryParams.userId" :min="1" controls-position="right" style="width: 180px" />
      </el-form-item>
      <el-form-item label="业务类型" prop="bizType">
        <el-input
          v-model="queryParams.bizType"
          placeholder="请输入业务类型"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="变更类型" prop="changeType">
        <el-select v-model="queryParams.changeType" placeholder="请选择变更类型" clearable style="width: 160px">
          <el-option label="赠送" value="GRANT" />
          <el-option label="消耗" value="CONSUME" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleGrant" v-hasPermi="['ai:wallet:grant']">赠送算力</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="flowList">
      <el-table-column label="流水ID" align="center" prop="flowId" width="90" />
      <el-table-column label="用户ID" align="center" prop="userId" width="90" />
      <el-table-column label="业务类型" align="center" prop="bizType" min-width="140" />
      <el-table-column label="业务ID" align="center" prop="bizId" width="100" />
      <el-table-column label="变更类型" align="center" prop="changeType" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.changeType === 'GRANT' ? 'success' : 'warning'">
            {{ scope.row.changeType }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="变更算力" align="center" prop="powerNum" width="100" />
      <el-table-column label="变更前" align="center" prop="beforeBalance" width="100" />
      <el-table-column label="变更后" align="center" prop="afterBalance" width="100" />
      <el-table-column label="备注" align="center" prop="remark" min-width="220" show-overflow-tooltip />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog title="赠送算力" v-model="open" width="480px" append-to-body>
      <el-form ref="grantRef" :model="grantForm" :rules="rules" label-width="90px">
        <el-form-item label="用户ID" prop="userId">
          <el-input-number v-model="grantForm.userId" :min="1" style="width: 100%" />
        </el-form-item>
        <el-form-item label="赠送算力" prop="powerNum">
          <el-input-number v-model="grantForm.powerNum" :min="1" style="width: 100%" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="grantForm.remark" type="textarea" :rows="3" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitGrant">确 定</el-button>
          <el-button @click="open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiWallet">
import { grantPower, listWalletFlow } from "@/api/ai/wallet"

const { proxy } = getCurrentInstance()

const flowList = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)
const open = ref(false)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: 1,
    bizType: undefined,
    changeType: undefined
  },
  grantForm: {
    userId: 1,
    powerNum: 100,
    remark: "后台赠送算力"
  },
  rules: {
    userId: [{ required: true, message: "用户ID不能为空", trigger: "blur" }],
    powerNum: [{ required: true, message: "赠送算力不能为空", trigger: "blur" }]
  }
})

const { queryParams, grantForm, rules } = toRefs(data)

function getList() {
  loading.value = true
  listWalletFlow(queryParams.value).then(response => {
    flowList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  queryParams.value.userId = 1
  handleQuery()
}

function handleGrant() {
  grantForm.value = {
    userId: queryParams.value.userId || 1,
    powerNum: 100,
    remark: "后台赠送算力"
  }
  open.value = true
  proxy?.resetForm?.("grantRef")
}

function submitGrant() {
  proxy.$refs["grantRef"].validate(valid => {
    if (valid) {
      grantPower(grantForm.value).then(() => {
        proxy.$modal.msgSuccess("赠送成功")
        open.value = false
        getList()
      })
    }
  })
}

getList()
</script>
