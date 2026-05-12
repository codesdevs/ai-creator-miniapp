<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="所属模型" prop="modelId">
        <el-select v-model="queryParams.modelId" placeholder="请选择模型" clearable filterable style="width: 200px">
          <el-option v-for="item in modelOptions" :key="item.modelId" :label="item.modelName" :value="item.modelId" />
        </el-select>
      </el-form-item>
      <el-form-item label="版本名称" prop="versionName">
        <el-input
          v-model="queryParams.versionName"
          placeholder="请输入版本名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="实际模型名" prop="apiModelName">
        <el-input
          v-model="queryParams.apiModelName"
          placeholder="请输入实际模型名"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:modelVersion:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['ai:modelVersion:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['ai:modelVersion:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="versionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="模型 / 版本" align="center" min-width="220">
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-main">{{ scope.row.modelName || "-" }}</div>
            <div class="summary-sub">{{ scope.row.versionName || "-" }} / {{ scope.row.versionCode || "-" }}</div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="实际模型" align="center" min-width="180" show-overflow-tooltip>
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-main">{{ scope.row.apiModelName || "-" }}</div>
            <div class="summary-sub">ID: {{ scope.row.versionId || "-" }}</div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="计费 / 上下文" align="center" min-width="180">
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-main">算力 {{ scope.row.powerCost ?? 0 }}</div>
            <div class="summary-sub">上下文 {{ scope.row.contextLength ?? 0 }}</div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="输入 / 输出单价" align="center" min-width="180">
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-main">输入 {{ scope.row.inputPrice ?? 0 }}</div>
            <div class="summary-sub">输出 {{ scope.row.outputPrice ?? 0 }}</div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="能力摘要" align="center" min-width="260">
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-tags">
              <el-tag
                v-for="item in formatArrayField(scope.row.supportRatio).slice(0, 3)"
                :key="`ratio-${scope.row.versionId}-${item}`"
                size="small"
                effect="plain"
              >
                {{ item }}
              </el-tag>
              <span v-if="!formatArrayField(scope.row.supportRatio).length" class="summary-sub">未配置比例</span>
            </div>
            <div class="summary-sub">
              模式: {{ formatArrayField(scope.row.supportMode).join(" / ") || "-" }}
            </div>
          </div>
        </template>
      </el-table-column>
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
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ai:modelVersion:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:modelVersion:remove']">删除</el-button>
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

    <el-dialog :title="title" v-model="open" width="860px" append-to-body>
      <el-form ref="versionRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="所属模型" prop="modelId">
              <el-select v-model="form.modelId" placeholder="请选择模型" filterable>
                <el-option v-for="item in modelOptions" :key="item.modelId" :label="item.modelName" :value="item.modelId" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="版本名称" prop="versionName">
              <el-input v-model="form.versionName" placeholder="请输入版本名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="版本编码" prop="versionCode">
              <el-input v-model="form.versionCode" placeholder="请输入版本编码" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="实际模型名" prop="apiModelName">
              <el-input v-model="form.apiModelName" placeholder="请输入实际请求模型名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="消耗算力" prop="powerCost">
              <el-input-number v-model="form.powerCost" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="上下文长度" prop="contextLength">
              <el-input-number v-model="form.contextLength" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="输入单价" prop="inputPrice">
              <el-input-number v-model="form.inputPrice" :min="0" :precision="4" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="输出单价" prop="outputPrice">
              <el-input-number v-model="form.outputPrice" :min="0" :precision="4" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="速度等级" prop="speedLevel">
              <el-input-number v-model="form.speedLevel" :min="0" :max="10" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="质量等级" prop="qualityLevel">
              <el-input-number v-model="form.qualityLevel" :min="0" :max="10" style="width: 100%" />
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
            <div class="config-panel">
              <div class="config-panel__title">创作能力配置</div>
              <div class="config-panel__desc">支持自定义录入，也可直接选常用项。保存时会自动转成数组格式。</div>
              <el-row :gutter="16">
                <el-col :span="24">
                  <el-form-item label="支持比例" prop="supportRatio">
                    <el-select
                      v-model="ratioValues"
                      multiple
                      filterable
                      allow-create
                      default-first-option
                      placeholder="请选择或输入支持比例"
                      style="width: 100%"
                    >
                      <el-option v-for="item in ratioPresetOptions" :key="item" :label="item" :value="item" />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="支持风格" prop="supportStyle">
                    <el-select
                      v-model="styleValues"
                      multiple
                      filterable
                      allow-create
                      default-first-option
                      placeholder="请选择或输入支持风格"
                      style="width: 100%"
                    >
                      <el-option v-for="item in stylePresetOptions" :key="item" :label="item" :value="item" />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="支持模式" prop="supportMode">
                    <el-select
                      v-model="modeValues"
                      multiple
                      filterable
                      allow-create
                      default-first-option
                      placeholder="请选择或输入支持模式"
                      style="width: 100%"
                    >
                      <el-option v-for="item in modePresetOptions" :key="item" :label="item" :value="item" />
                    </el-select>
                  </el-form-item>
                </el-col>
              </el-row>
            </div>
          </el-col>
          <el-col :span="24">
            <el-form-item label="扩展配置" prop="extConfig">
              <el-input v-model="form.extConfig" type="textarea" :rows="3" placeholder="请输入扩展配置 JSON" />
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

<script setup name="AiModelVersion">
import { listModel } from "@/api/ai/model"
import { addModelVersion, delModelVersion, getModelVersion, listModelVersion, updateModelVersion } from "@/api/ai/modelVersion"
import { computed } from "vue"

const { proxy } = getCurrentInstance()

const versionList = ref([])
const modelOptions = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const ratioPresetOptions = ["1:1", "3:4", "4:3", "9:16", "16:9", "21:9"]
const stylePresetOptions = ["PHOTO", "REALISTIC", "ANIME", "ILLUSTRATION", "3D", "WATERCOLOR", "CUSTOM"]
const modePresetOptions = ["TEXT_TO_IMAGE", "IMAGE_TO_IMAGE", "UPSCALE", "INPAINT"]

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    modelId: undefined,
    versionName: undefined,
    apiModelName: undefined,
    status: undefined
  },
  rules: {
    modelId: [{ required: true, message: "所属模型不能为空", trigger: "change" }],
    versionName: [{ required: true, message: "版本名称不能为空", trigger: "blur" }],
    versionCode: [{ required: true, message: "版本编码不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

const ratioValues = computed({
  get: () => parseArrayLike(form.value.supportRatio),
  set: value => {
    form.value.supportRatio = stringifyArrayLike(value)
  }
})

const styleValues = computed({
  get: () => parseArrayLike(form.value.supportStyle),
  set: value => {
    form.value.supportStyle = stringifyArrayLike(value)
  }
})

const modeValues = computed({
  get: () => parseArrayLike(form.value.supportMode),
  set: value => {
    form.value.supportMode = stringifyArrayLike(value)
  }
})

function parseArrayLike(value) {
  if (!value) return []
  if (Array.isArray(value)) return value.filter(Boolean).map(item => String(item).trim()).filter(Boolean)
  const text = String(value).trim()
  if (!text) return []
  try {
    const parsed = JSON.parse(text)
    if (Array.isArray(parsed)) {
      return parsed.filter(Boolean).map(item => String(item).trim()).filter(Boolean)
    }
  } catch (error) {
    // Fall through to comma/newline split.
  }
  return text
    .split(/[,\n，]/)
    .map(item => item.trim())
    .filter(Boolean)
}

function stringifyArrayLike(value) {
  const normalized = (value || []).map(item => String(item).trim()).filter(Boolean)
  return normalized.length ? JSON.stringify(normalized) : undefined
}

function formatArrayField(value) {
  return parseArrayLike(value)
}

function getList() {
  loading.value = true
  listModelVersion(queryParams.value).then(response => {
    versionList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function getModelOptions() {
  listModel({ pageNum: 1, pageSize: 1000, status: "0" }).then(response => {
    modelOptions.value = response.rows || []
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    versionId: undefined,
    modelId: undefined,
    versionName: undefined,
    versionCode: undefined,
    apiModelName: undefined,
    powerCost: 0,
    contextLength: 0,
    inputPrice: 0,
    outputPrice: 0,
    speedLevel: 0,
    qualityLevel: 0,
    supportRatio: undefined,
    supportStyle: undefined,
    supportMode: undefined,
    extConfig: undefined,
    status: "0",
    remark: undefined
  }
  proxy.resetForm("versionRef")
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
  ids.value = selection.map(item => item.versionId)
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加模型版本"
}

function handleUpdate(row) {
  reset()
  const versionId = row.versionId || ids.value[0]
  getModelVersion(versionId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改模型版本"
  })
}

function submitForm() {
  proxy.$refs["versionRef"].validate(valid => {
    if (valid) {
      const request = form.value.versionId ? updateModelVersion(form.value) : addModelVersion(form.value)
      request.then(() => {
        proxy.$modal.msgSuccess(form.value.versionId ? "修改成功" : "新增成功")
        open.value = false
        getList()
      })
    }
  })
}

function handleDelete(row) {
  const versionIds = row.versionId || ids.value
  proxy.$modal.confirm('是否确认删除模型版本编号为"' + versionIds + '"的数据项？').then(function() {
    return delModelVersion(versionIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getModelOptions()
getList()
</script>

<style scoped>
.summary-cell {
  display: flex;
  flex-direction: column;
  gap: 4px;
  line-height: 1.4;
}

.summary-main {
  color: #111827;
  font-weight: 500;
}

.summary-sub {
  color: #6b7280;
  font-size: 12px;
}

.summary-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.config-panel {
  padding: 16px;
  border: 1px solid #ebeef5;
  border-radius: 10px;
  background: #fafafa;
}

.config-panel__title {
  margin-bottom: 6px;
  color: #111827;
  font-size: 14px;
  font-weight: 600;
}

.config-panel__desc {
  margin-bottom: 16px;
  color: #6b7280;
  font-size: 12px;
  line-height: 1.6;
}
</style>
