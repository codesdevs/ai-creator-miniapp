<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="用户ID" prop="userId">
        <el-input-number v-model="queryParams.userId" :min="1" controls-position="right" style="width: 180px" />
      </el-form-item>
      <el-form-item label="用户编号" prop="userNo">
        <el-input
          v-model="queryParams.userNo"
          placeholder="请输入用户编号"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="昵称" prop="nickName">
        <el-input
          v-model="queryParams.nickName"
          placeholder="请输入昵称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input
          v-model="queryParams.email"
          placeholder="请输入邮箱"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="手机号" prop="mobile">
        <el-input
          v-model="queryParams.mobile"
          placeholder="请输入手机号"
          clearable
          style="width: 180px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 140px">
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
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="userList">
      <el-table-column label="用户ID" align="center" prop="userId" width="90" />
      <el-table-column label="用户编号" align="center" prop="userNo" min-width="150" />
      <el-table-column label="昵称" align="center" prop="nickName" min-width="120" />
      <el-table-column label="手机号" align="center" prop="mobile" width="130" />
      <el-table-column label="认证方式" align="center" prop="authTypes" min-width="150">
        <template #default="scope">
          <el-tag
            v-for="item in formatAuthTypes(scope.row.authTypes)"
            :key="item"
            type="info"
            style="margin-right: 6px"
          >
            {{ item }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="当前算力" align="center" prop="balancePower" width="100" />
      <el-table-column label="累计消耗" align="center" prop="totalConsumePower" width="100" />
      <el-table-column label="累计赠送" align="center" prop="totalGivePower" width="100" />
      <el-table-column label="任务数" align="center" prop="taskCount" width="90" />
      <el-table-column label="邀请人数" align="center" prop="inviteCount" width="90" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">
            {{ scope.row.status === '0' ? '正常' : '停用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="操作" align="center" width="230">
        <template #default="scope">
          <el-button link type="success" icon="View" @click="handleDetail(scope.row)">详情</el-button>
          <el-button link type="primary" icon="Tickets" @click="goTasks(scope.row)">任务</el-button>
          <el-button link type="warning" icon="Wallet" @click="goWallet(scope.row)">钱包</el-button>
          <el-button link type="info" icon="Share" @click="goInvites(scope.row)">邀请</el-button>
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

    <el-drawer v-model="detailOpen" title="会员详情" size="780px">
      <template v-if="detailLoading">
        <div class="detail-state">加载中...</div>
      </template>
      <template v-else-if="detailUser">
        <div class="detail-actions">
          <el-button type="primary" icon="Plus" @click="handleGrant(detailUser)">赠送算力</el-button>
          <el-button type="warning" icon="Wallet" @click="goWallet(detailUser)">钱包流水</el-button>
          <el-button type="success" icon="Tickets" @click="goTasks(detailUser)">任务列表</el-button>
          <el-button type="info" icon="Share" @click="goInvites(detailUser)">邀请关系</el-button>
        </div>

        <el-descriptions :column="2" border>
          <el-descriptions-item label="用户ID">{{ detailUser.userId }}</el-descriptions-item>
          <el-descriptions-item label="用户编号">{{ detailUser.userNo || '-' }}</el-descriptions-item>
          <el-descriptions-item label="昵称">{{ detailUser.nickName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="邮箱">{{ detailUser.email || '-' }}</el-descriptions-item>
          <el-descriptions-item label="手机号">{{ detailUser.mobile || '-' }}</el-descriptions-item>
          <el-descriptions-item label="认证方式">
            <el-tag
              v-for="item in formatAuthTypes(detailUser.authTypes)"
              :key="item"
              type="info"
              style="margin-right: 6px"
            >
              {{ item }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="状态">
            <el-tag :type="detailUser.status === '0' ? 'success' : 'danger'">
              {{ detailUser.status === '0' ? '正常' : '停用' }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="邀请码">{{ detailUser.inviteCode || '-' }}</el-descriptions-item>
          <el-descriptions-item label="邀请人数">{{ detailUser.inviteCount || 0 }}</el-descriptions-item>
          <el-descriptions-item label="创建时间">{{ detailUser.createTime || '-' }}</el-descriptions-item>
          <el-descriptions-item label="最近登录IP">{{ detailUser.lastLoginIp || '-' }}</el-descriptions-item>
          <el-descriptions-item label="最近登录时间">{{ detailUser.lastLoginTime || '-' }}</el-descriptions-item>
          <el-descriptions-item label="最近登录设备" :span="2">{{ detailUser.lastLoginDevice || '-' }}</el-descriptions-item>
        </el-descriptions>

        <div class="block-title">钱包摘要</div>
        <el-row :gutter="12">
          <el-col :span="6"><el-card shadow="never">当前算力：{{ detailWallet.balancePower || 0 }}</el-card></el-col>
          <el-col :span="6"><el-card shadow="never">冻结算力：{{ detailWallet.freezePower || 0 }}</el-card></el-col>
          <el-col :span="6"><el-card shadow="never">累计消耗：{{ detailWallet.totalConsumePower || 0 }}</el-card></el-col>
          <el-col :span="6"><el-card shadow="never">累计赠送：{{ detailWallet.totalGivePower || 0 }}</el-card></el-col>
        </el-row>

        <div class="block-title">最近任务</div>
        <el-table :data="detailTasks" size="small">
          <el-table-column label="任务编号" prop="taskNo" min-width="170" />
          <el-table-column label="模型" prop="modelName" min-width="120" />
          <el-table-column label="状态" prop="status" width="100">
            <template #default="scope">
              <el-tag :type="statusTagType(scope.row.status)">
                {{ formatTaskStatus(scope.row.status) }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="消耗算力" prop="powerCost" width="100" />
          <el-table-column label="提交时间" prop="submitTime" width="170" />
          <el-table-column label="操作" width="90">
            <template #default="scope">
              <el-button link type="primary" @click="goTasks(detailUser, scope.row)">查看</el-button>
            </template>
          </el-table-column>
        </el-table>

        <div class="block-title">最近邀请</div>
        <el-table :data="detailInvites" size="small">
          <el-table-column label="被邀请人ID" prop="inviteeUserId" width="110" />
          <el-table-column label="被邀请人编号" prop="inviteeUserNo" min-width="150" />
          <el-table-column label="被邀请人昵称" prop="inviteeNickName" min-width="120" />
          <el-table-column label="邀请码" prop="inviteCode" min-width="120" />
          <el-table-column label="创建时间" prop="createTime" width="170" />
          <el-table-column label="操作" width="90">
            <template #default="scope">
              <el-button link type="primary" @click="goUserDetail(scope.row.inviteeUserId)">查看</el-button>
            </template>
          </el-table-column>
        </el-table>

        <div class="block-title">最近流水</div>
        <el-table :data="detailFlows" size="small">
          <el-table-column label="业务类型" prop="bizType" min-width="130">
            <template #default="scope">
              {{ formatBizType(scope.row.bizType) }}
            </template>
          </el-table-column>
          <el-table-column label="变更类型" prop="changeType" width="100">
            <template #default="scope">
              <el-tag :type="scope.row.changeType === 'GRANT' ? 'success' : 'warning'">
                {{ formatChangeType(scope.row.changeType) }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="变更算力" prop="powerNum" width="100" />
          <el-table-column label="变更后余额" prop="afterBalance" width="110" />
          <el-table-column label="备注" prop="remark" min-width="180" show-overflow-tooltip />
          <el-table-column label="创建时间" prop="createTime" width="170" />
        </el-table>
      </template>
      <template v-else>
        <div class="detail-state">暂无用户数据</div>
      </template>
    </el-drawer>

    <el-dialog title="赠送算力" v-model="grantOpen" width="480px" append-to-body>
      <el-form ref="grantRef" :model="grantForm" :rules="grantRules" label-width="90px">
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
          <el-button @click="grantOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiUser">
import { onActivated } from "vue"
import { useRoute } from "vue-router"
import { listTask } from "@/api/ai/task"
import { getUserDetail, listUser } from "@/api/ai/user"
import { listUserInvite } from "@/api/ai/userInvite"
import { getWalletInfo, grantPower, listWalletFlow } from "@/api/ai/wallet"

const { proxy } = getCurrentInstance()
const route = useRoute()

const userList = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)
const detailOpen = ref(false)
const detailLoading = ref(false)
const detailUser = ref(null)
const detailWallet = ref({})
const detailTasks = ref([])
const detailInvites = ref([])
const detailFlows = ref([])
const grantOpen = ref(false)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: undefined,
    userNo: undefined,
    nickName: undefined,
    email: undefined,
    mobile: undefined,
    status: undefined
  },
  grantForm: {
    userId: undefined,
    powerNum: 100,
    remark: "后台赠送算力"
  },
  grantRules: {
    userId: [{ required: true, message: "用户ID不能为空", trigger: "blur" }],
    powerNum: [{ required: true, message: "赠送算力不能为空", trigger: "blur" }]
  }
})

const { queryParams, grantForm, grantRules } = toRefs(data)

function getList() {
  loading.value = true
  listUser(queryParams.value).then(response => {
    userList.value = response.rows
    total.value = response.total
    loading.value = false
    if (route.query.detailUserId) {
      const targetUser = userList.value.find(item => item.userId === Number(route.query.detailUserId))
      if (targetUser) {
        handleDetail(targetUser)
      }
    }
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function formatAuthTypes(value) {
  if (!value) {
    return ["-"]
  }
  return value.split(",").map(item => {
    if (item === "WECHAT_OPENID") return "微信"
    if (item === "WECHAT_UNIONID") return "微信UnionID"
    if (item === "DEV") return "开发登录"
    return item
  })
}

function goTasks(row, taskRow) {
  proxy.$router.push({
    path: '/ai/task',
    query: {
      userId: row.userId,
      taskNo: taskRow?.taskNo
    }
  })
}

function goWallet(row) {
  proxy.$router.push({
    path: '/ai/wallet',
    query: { userId: row.userId }
  })
}

function goInvites(row) {
  proxy.$router.push({
    path: '/ai/userInvite',
    query: {
      inviterUserId: row.userId,
      inviteCode: row.inviteCode
    }
  })
}

function goUserDetail(userId) {
  detailOpen.value = false
  proxy.$router.push({
    path: '/ai/user',
    query: {
      userId,
      detailUserId: userId
    }
  })
}

function handleDetail(row) {
  detailOpen.value = true
  detailLoading.value = true
  Promise.all([
    getUserDetail(row.userId),
    getWalletInfo(row.userId),
    listTask({ pageNum: 1, pageSize: 5, userId: row.userId }),
    listUserInvite({ pageNum: 1, pageSize: 5, inviterUserId: row.userId }),
    listWalletFlow({ pageNum: 1, pageSize: 5, userId: row.userId })
  ]).then(([userRes, walletRes, taskRes, inviteRes, flowRes]) => {
    detailUser.value = (userRes.rows || [])[0] || null
    detailWallet.value = walletRes.data || {}
    detailTasks.value = taskRes.rows || []
    detailInvites.value = inviteRes.rows || []
    detailFlows.value = flowRes.rows || []
  }).finally(() => {
    detailLoading.value = false
  })
}

function handleGrant(row) {
  grantForm.value = {
    userId: row.userId,
    powerNum: 100,
    remark: "后台赠送算力"
  }
  grantOpen.value = true
  proxy?.resetForm?.("grantRef")
}

function submitGrant() {
  proxy.$refs["grantRef"].validate(valid => {
    if (valid) {
      grantPower(grantForm.value).then(() => {
        proxy.$modal.msgSuccess("赠送成功")
        grantOpen.value = false
        getList()
        if (detailUser.value?.userId === grantForm.value.userId) {
          handleDetail({ userId: grantForm.value.userId })
        }
      })
    }
  })
}

function statusTagType(status) {
  if (status === "SUCCESS") return "success"
  if (status === "FAIL") return "danger"
  if (status === "RUNNING") return "warning"
  return "info"
}

function formatTaskStatus(status) {
  if (status === "PENDING") return "待执行"
  if (status === "RUNNING") return "执行中"
  if (status === "SUCCESS") return "成功"
  if (status === "FAIL") return "失败"
  return status || "-"
}

function formatBizType(bizType) {
  if (bizType === "ADMIN_GRANT") return "后台赠送"
  if (bizType === "TASK_CONSUME") return "任务消耗"
  if (bizType === "TASK_REFUND") return "任务退款"
  return bizType || "-"
}

function formatChangeType(changeType) {
  if (changeType === "GRANT") return "赠送"
  if (changeType === "CONSUME") return "消耗"
  return changeType || "-"
}

if (route.query.userId) {
  queryParams.value.userId = Number(route.query.userId)
}

getList()

onActivated(getList)
</script>

<style scoped>
.detail-actions {
  margin-bottom: 16px;
}

.block-title {
  margin: 20px 0 12px;
  font-size: 14px;
  font-weight: 600;
}

.detail-state {
  padding: 24px 0;
  color: var(--el-text-color-secondary);
}
</style>
