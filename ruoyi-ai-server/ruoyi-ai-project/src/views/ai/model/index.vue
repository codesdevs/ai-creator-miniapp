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
      <el-form-item label="官方提供商" prop="officialProviderId">
        <el-select v-model="queryParams.officialProviderId" placeholder="请选择提供商" clearable filterable style="width: 200px">
          <el-option v-for="item in providerOptions" :key="item.providerId" :label="item.providerName" :value="item.providerId" />
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
      <el-table-column label="模型" align="center" min-width="220">
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-main">{{ scope.row.modelName || "-" }}</div>
            <div class="summary-sub">{{ scope.row.modelCode || "-" }} / ID {{ scope.row.modelId || "-" }}</div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="类型 / 提供商" align="center" min-width="180">
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-main">{{ scope.row.modelType || "-" }}</div>
            <div class="summary-sub">{{ scope.row.providerName || scope.row.provider || "-" }}</div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="能力摘要" align="center" min-width="240">
        <template #default="scope">
          <div class="summary-cell">
            <div class="summary-tags">
              <el-tag
                v-for="item in formatArrayField(scope.row.capabilities).slice(0, 3)"
                :key="`capability-${scope.row.modelId}-${item}`"
                size="small"
                effect="plain"
              >
                {{ item }}
              </el-tag>
              <span v-if="!formatArrayField(scope.row.capabilities).length" class="summary-sub">未配置能力</span>
            </div>
            <div class="summary-sub">排序 {{ scope.row.sort ?? 0 }}</div>
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
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="320">
        <template #default="scope">
          <el-button link type="primary" icon="Tickets" @click="handleOpenModelAsset(scope.row, 'version')">版本管理</el-button>
          <el-button link type="primary" icon="Share" @click="handleOpenModelAsset(scope.row, 'relation')">支持渠道</el-button>
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
            <el-form-item label="官方提供商" prop="officialProviderId">
              <el-select v-model="form.officialProviderId" placeholder="请选择提供商" filterable>
                <el-option v-for="item in providerOptions" :key="item.providerId" :label="item.providerName" :value="item.providerId" />
              </el-select>
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
            <el-form-item label="能力标签" prop="capabilities">
              <el-input v-model="form.capabilities" type="textarea" :rows="2" placeholder='例如 ["text_to_image","image_to_image"]' />
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

    <el-dialog v-model="assetOpen" width="1100px" append-to-body destroy-on-close>
      <template #header>
        <span>{{ currentModel.modelName || "模型管理" }} / {{ assetTab === "version" ? "版本管理" : "支持渠道" }}</span>
      </template>

      <el-tabs v-model="assetTab" @tab-change="handleAssetTabChange">
        <el-tab-pane label="版本管理" name="version">
          <el-row :gutter="10" class="mb8">
            <el-col :span="1.5"><el-button type="primary" plain icon="Plus" @click="handleAddVersion" v-hasPermi="['ai:modelVersion:add']">新增版本</el-button></el-col>
          </el-row>
          <el-table v-loading="assetLoading" :data="versionList">
            <el-table-column label="版本" min-width="220">
              <template #default="scope">
                <div class="summary-cell">
                  <div class="summary-main">{{ scope.row.versionName || "-" }}</div>
                  <div class="summary-sub">{{ scope.row.versionCode || "-" }} / ID {{ scope.row.versionId || "-" }}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="实际模型" min-width="180" show-overflow-tooltip>
              <template #default="scope">
                <div class="summary-cell">
                  <div class="summary-main">{{ scope.row.apiModelName || "-" }}</div>
                  <div class="summary-sub">上下文 {{ scope.row.contextLength ?? 0 }}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="计费摘要" min-width="180">
              <template #default="scope">
                <div class="summary-cell">
                  <div class="summary-main">算力 {{ scope.row.powerCost ?? 0 }}</div>
                  <div class="summary-sub">输入 {{ scope.row.inputPrice ?? 0 }} / 输出 {{ scope.row.outputPrice ?? 0 }}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="比例 / 模式" min-width="240">
              <template #default="scope">
                <div class="summary-cell">
                  <div class="summary-tags">
                    <el-tag
                      v-for="item in formatArrayField(scope.row.supportRatio).slice(0, 3)"
                      :key="`asset-ratio-${scope.row.versionId}-${item}`"
                      size="small"
                      effect="plain"
                    >
                      {{ item }}
                    </el-tag>
                    <span v-if="!formatArrayField(scope.row.supportRatio).length" class="summary-sub">未配置比例</span>
                  </div>
                  <div class="summary-sub">模式: {{ formatArrayField(scope.row.supportMode).join(" / ") || "-" }}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="状态" prop="status" width="90">
              <template #default="scope"><el-tag :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag></template>
            </el-table-column>
            <el-table-column label="操作" width="180">
              <template #default="scope">
                <el-button link type="primary" icon="Edit" @click="handleEditVersion(scope.row)" v-hasPermi="['ai:modelVersion:edit']">修改</el-button>
                <el-button link type="primary" icon="Delete" @click="handleDeleteVersion(scope.row)" v-hasPermi="['ai:modelVersion:remove']">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>

        <el-tab-pane label="支持渠道" name="relation">
          <el-row :gutter="10" class="mb8">
            <el-col :span="1.5"><el-button type="primary" plain icon="Plus" @click="handleAddRelation" v-hasPermi="['ai:channelModelRelation:add']">新增映射</el-button></el-col>
          </el-row>
          <el-table v-loading="assetLoading" :data="relationList">
            <el-table-column label="渠道" min-width="220">
              <template #default="scope">
                <div class="summary-cell">
                  <div class="summary-main">{{ scope.row.channelName || "-" }}</div>
                  <div class="summary-sub">{{ scope.row.providerName || "-" }}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="版本 / 远端模型" min-width="240">
              <template #default="scope">
                <div class="summary-cell">
                  <div class="summary-main">{{ scope.row.versionName || "-" }}</div>
                  <div class="summary-sub">{{ scope.row.remoteModelName || "-" }}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="调度摘要" min-width="180">
              <template #default="scope">
                <div class="summary-cell">
                  <div class="summary-main">系数 {{ scope.row.priceRatio ?? 0 }}</div>
                  <div class="summary-sub">优先级 {{ scope.row.priority ?? 0 }} / 权重 {{ scope.row.weight ?? 0 }}</div>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="状态" prop="enabled" width="90">
              <template #default="scope"><el-tag :type="scope.row.enabled === '0' ? 'success' : 'info'">{{ scope.row.enabled === '0' ? '启用' : '停用' }}</el-tag></template>
            </el-table-column>
            <el-table-column label="操作" width="180">
              <template #default="scope">
                <el-button link type="primary" icon="Edit" @click="handleEditRelation(scope.row)" v-hasPermi="['ai:channelModelRelation:edit']">修改</el-button>
                <el-button link type="primary" icon="Delete" @click="handleDeleteRelation(scope.row)" v-hasPermi="['ai:channelModelRelation:remove']">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>
      </el-tabs>
    </el-dialog>

    <el-dialog :title="versionDialogTitle" v-model="versionOpen" width="860px" append-to-body>
      <el-form ref="versionRef" :model="versionForm" :rules="versionRules" label-width="100px">
        <el-row>
          <el-col :span="12"><el-form-item label="版本名称" prop="versionName"><el-input v-model="versionForm.versionName" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="版本编码" prop="versionCode"><el-input v-model="versionForm.versionCode" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="实际模型名" prop="apiModelName"><el-input v-model="versionForm.apiModelName" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="消耗算力" prop="powerCost"><el-input-number v-model="versionForm.powerCost" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="上下文长度" prop="contextLength"><el-input-number v-model="versionForm.contextLength" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="输入单价" prop="inputPrice"><el-input-number v-model="versionForm.inputPrice" :min="0" :precision="4" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="输出单价" prop="outputPrice"><el-input-number v-model="versionForm.outputPrice" :min="0" :precision="4" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="速度等级" prop="speedLevel"><el-input-number v-model="versionForm.speedLevel" :min="0" :max="10" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="质量等级" prop="qualityLevel"><el-input-number v-model="versionForm.qualityLevel" :min="0" :max="10" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="状态" prop="status"><el-radio-group v-model="versionForm.status"><el-radio value="0">正常</el-radio><el-radio value="1">停用</el-radio></el-radio-group></el-form-item></el-col>
          <el-col :span="24">
            <div class="config-panel">
              <div class="config-panel__title">创作能力配置</div>
              <div class="config-panel__desc">支持自定义录入，也可直接选常用项。保存时会自动转成数组格式。</div>
              <el-row :gutter="16">
                <el-col :span="24">
                  <el-form-item label="支持比例" prop="supportRatio">
                    <el-select
                      v-model="versionRatioValues"
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
                      v-model="versionStyleValues"
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
                      v-model="versionModeValues"
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
          <el-col :span="24"><el-form-item label="扩展配置" prop="extConfig"><el-input v-model="versionForm.extConfig" type="textarea" :rows="3" /></el-form-item></el-col>
          <el-col :span="24"><el-form-item label="备注" prop="remark"><el-input v-model="versionForm.remark" type="textarea" :rows="2" /></el-form-item></el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitVersionForm">确 定</el-button>
          <el-button @click="versionOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog :title="relationDialogTitle" v-model="relationOpen" width="760px" append-to-body>
      <el-form ref="relationRef" :model="relationForm" :rules="relationRules" label-width="110px">
        <el-form-item label="所属渠道" prop="channelId">
          <el-select v-model="relationForm.channelId" filterable style="width: 100%">
            <el-option v-for="item in channelOptions" :key="item.channelId" :label="item.providerName ? `${item.providerName} / ${item.channelName}` : item.channelName" :value="item.channelId" />
          </el-select>
        </el-form-item>
        <el-form-item label="模型版本" prop="modelVersionId">
          <el-select v-model="relationForm.modelVersionId" filterable style="width: 100%">
            <el-option v-for="item in versionList" :key="item.versionId" :label="item.versionName" :value="item.versionId" />
          </el-select>
        </el-form-item>
        <el-form-item label="远程模型名" prop="remoteModelName"><el-input v-model="relationForm.remoteModelName" /></el-form-item>
        <el-row>
          <el-col :span="12"><el-form-item label="价格系数" prop="priceRatio"><el-input-number v-model="relationForm.priceRatio" :min="0" :precision="4" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="优先级" prop="priority"><el-input-number v-model="relationForm.priority" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="权重" prop="weight"><el-input-number v-model="relationForm.weight" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="最大QPS" prop="maxQps"><el-input-number v-model="relationForm.maxQps" :min="0" style="width: 100%" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="状态" prop="enabled"><el-radio-group v-model="relationForm.enabled"><el-radio value="0">启用</el-radio><el-radio value="1">停用</el-radio></el-radio-group></el-form-item>
        <el-form-item label="备注" prop="remark"><el-input v-model="relationForm.remark" type="textarea" :rows="3" /></el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitRelationForm">确 定</el-button>
          <el-button @click="relationOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiModel">
import { addModel, delModel, getModel, listModel, updateModel } from "@/api/ai/model"
import { listProvider } from "@/api/ai/provider"
import { addModelVersion, delModelVersion, getModelVersion, listModelVersion, updateModelVersion } from "@/api/ai/modelVersion"
import { addChannelModelRelation, delChannelModelRelation, getChannelModelRelation, listChannelModelRelation, updateChannelModelRelation } from "@/api/ai/channelModelRelation"
import { listProviderChannel } from "@/api/ai/providerChannel"
import { computed } from "vue"

const { proxy } = getCurrentInstance()

const modelList = ref([])
const providerOptions = ref([])
const channelOptions = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const assetOpen = ref(false)
const assetLoading = ref(false)
const assetTab = ref("version")
const currentModel = ref({})
const versionList = ref([])
const relationList = ref([])
const versionOpen = ref(false)
const relationOpen = ref(false)
const versionDialogTitle = ref("")
const relationDialogTitle = ref("")
const ratioPresetOptions = ["1:1", "3:4", "4:3", "9:16", "16:9", "21:9"]
const stylePresetOptions = ["PHOTO", "REALISTIC", "ANIME", "ILLUSTRATION", "3D", "WATERCOLOR", "CUSTOM"]
const modePresetOptions = ["TEXT_TO_IMAGE", "IMAGE_TO_IMAGE", "UPSCALE", "INPAINT"]

const data = reactive({
  form: {},
  versionForm: {},
  relationForm: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    modelName: undefined,
    modelCode: undefined,
    modelType: undefined,
    officialProviderId: undefined,
    status: undefined
  },
  rules: {
    modelName: [{ required: true, message: "模型名称不能为空", trigger: "blur" }],
    modelCode: [{ required: true, message: "模型编码不能为空", trigger: "blur" }],
    modelType: [{ required: true, message: "模型类型不能为空", trigger: "change" }]
  },
  versionRules: {
    versionName: [{ required: true, message: "版本名称不能为空", trigger: "blur" }],
    versionCode: [{ required: true, message: "版本编码不能为空", trigger: "blur" }]
  },
  relationRules: {
    channelId: [{ required: true, message: "渠道不能为空", trigger: "change" }],
    modelVersionId: [{ required: true, message: "模型版本不能为空", trigger: "change" }],
    remoteModelName: [{ required: true, message: "远程模型名不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules, versionForm, relationForm, versionRules, relationRules } = toRefs(data)

const versionRatioValues = computed({
  get: () => parseArrayLike(versionForm.value.supportRatio),
  set: value => {
    versionForm.value.supportRatio = stringifyArrayLike(value)
  }
})

const versionStyleValues = computed({
  get: () => parseArrayLike(versionForm.value.supportStyle),
  set: value => {
    versionForm.value.supportStyle = stringifyArrayLike(value)
  }
})

const versionModeValues = computed({
  get: () => parseArrayLike(versionForm.value.supportMode),
  set: value => {
    versionForm.value.supportMode = stringifyArrayLike(value)
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
    // Fall through to plain split parsing.
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
  listModel(queryParams.value).then(response => {
    modelList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function getProviderOptions() {
  listProvider({ pageNum: 1, pageSize: 1000, status: "0" }).then(response => {
    providerOptions.value = response.rows || []
  })
}

function getChannelOptions() {
  listProviderChannel({ pageNum: 1, pageSize: 1000, status: "0" }).then(response => {
    channelOptions.value = response.rows || []
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
    officialProviderId: undefined,
    capabilities: undefined,
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

function handleOpenModelAsset(row, tab) {
  currentModel.value = row
  assetTab.value = tab
  assetOpen.value = true
  loadAssetData()
}

function handleAssetTabChange() {
  loadAssetData()
}

function loadAssetData() {
  if (!currentModel.value.modelId) return
  assetLoading.value = true
  listModelVersion({ pageNum: 1, pageSize: 1000, modelId: currentModel.value.modelId }).then(versionResponse => {
    versionList.value = versionResponse.rows || []
    const request = assetTab.value === "version"
      ? Promise.resolve({ rows: versionList.value })
      : listChannelModelRelation({ pageNum: 1, pageSize: 1000, modelId: currentModel.value.modelId })
    request.then(response => {
      if (assetTab.value === "relation") {
        relationList.value = response.rows || []
      }
      assetLoading.value = false
    })
  })
}

function resetVersionForm() {
  versionForm.value = {
    versionId: undefined,
    modelId: currentModel.value.modelId,
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

function handleAddVersion() {
  resetVersionForm()
  versionDialogTitle.value = "新增版本"
  versionOpen.value = true
}

function handleEditVersion(row) {
  resetVersionForm()
  getModelVersion(row.versionId).then(response => {
    versionForm.value = response.data
    versionDialogTitle.value = "修改版本"
    versionOpen.value = true
  })
}

function submitVersionForm() {
  versionForm.value.modelId = currentModel.value.modelId
  proxy.$refs["versionRef"].validate(valid => {
    if (!valid) return
    const request = versionForm.value.versionId ? updateModelVersion(versionForm.value) : addModelVersion(versionForm.value)
    request.then(() => {
      proxy.$modal.msgSuccess(versionForm.value.versionId ? "修改成功" : "新增成功")
      versionOpen.value = false
      loadAssetData()
    })
  })
}

function handleDeleteVersion(row) {
  proxy.$modal.confirm('是否确认删除版本编号为"' + row.versionId + '"的数据项？').then(function() {
    return delModelVersion(row.versionId)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    loadAssetData()
  }).catch(() => {})
}

function resetRelationForm() {
  relationForm.value = {
    relationId: undefined,
    channelId: undefined,
    modelVersionId: versionList.value.length ? versionList.value[0].versionId : undefined,
    remoteModelName: undefined,
    enabled: "0",
    priceRatio: 1,
    priority: 0,
    weight: 100,
    maxQps: 0,
    remark: undefined
  }
  proxy.resetForm("relationRef")
}

function handleAddRelation() {
  if (!versionList.value.length) {
    proxy.$modal.msgWarning("请先为当前模型配置版本")
    return
  }
  resetRelationForm()
  relationDialogTitle.value = "新增支持渠道"
  relationOpen.value = true
}

function handleEditRelation(row) {
  resetRelationForm()
  getChannelModelRelation(row.relationId).then(response => {
    relationForm.value = response.data
    relationDialogTitle.value = "修改支持渠道"
    relationOpen.value = true
  })
}

function submitRelationForm() {
  proxy.$refs["relationRef"].validate(valid => {
    if (!valid) return
    const request = relationForm.value.relationId ? updateChannelModelRelation(relationForm.value) : addChannelModelRelation(relationForm.value)
    request.then(() => {
      proxy.$modal.msgSuccess(relationForm.value.relationId ? "修改成功" : "新增成功")
      relationOpen.value = false
      loadAssetData()
    })
  })
}

function handleDeleteRelation(row) {
  proxy.$modal.confirm('是否确认删除映射编号为"' + row.relationId + '"的数据项？').then(function() {
    return delChannelModelRelation(row.relationId)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    loadAssetData()
  }).catch(() => {})
}

getList()
getProviderOptions()
getChannelOptions()
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
