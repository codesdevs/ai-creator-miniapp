<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="邀请人ID" prop="inviterUserId">
        <el-input-number v-model="queryParams.inviterUserId" :min="1" controls-position="right" style="width: 180px" />
      </el-form-item>
      <el-form-item label="被邀请人ID" prop="inviteeUserId">
        <el-input-number v-model="queryParams.inviteeUserId" :min="1" controls-position="right" style="width: 180px" />
      </el-form-item>
      <el-form-item label="邀请码" prop="inviteCode">
        <el-input
          v-model="queryParams.inviteCode"
          placeholder="请输入邀请码"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="inviteList">
      <el-table-column label="记录ID" align="center" prop="inviteId" width="90" />
      <el-table-column label="邀请码" align="center" prop="inviteCode" min-width="130" />
      <el-table-column label="邀请人ID" align="center" prop="inviterUserId" width="100" />
      <el-table-column label="邀请人编号" align="center" prop="inviterUserNo" min-width="150" />
      <el-table-column label="邀请人昵称" align="center" prop="inviterNickName" min-width="120" />
      <el-table-column label="被邀请人ID" align="center" prop="inviteeUserId" width="110" />
      <el-table-column label="被邀请人编号" align="center" prop="inviteeUserNo" min-width="150" />
      <el-table-column label="被邀请人昵称" align="center" prop="inviteeNickName" min-width="120" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="操作" align="center" width="180">
        <template #default="scope">
          <el-button link type="primary" @click="goUserDetail(scope.row.inviterUserId)">邀请人详情</el-button>
          <el-button link type="success" @click="goUserDetail(scope.row.inviteeUserId)">被邀请人详情</el-button>
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
  </div>
</template>

<script setup name="AiUserInvite">
import { useRoute } from "vue-router"
import { listUserInvite } from "@/api/ai/userInvite"

const route = useRoute()
const { proxy } = getCurrentInstance()

const inviteList = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    inviterUserId: undefined,
    inviteeUserId: undefined,
    inviteCode: undefined
  }
})

const { queryParams } = toRefs(data)

function getList() {
  loading.value = true
  listUserInvite(queryParams.value).then(response => {
    inviteList.value = response.rows
    total.value = response.total
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  queryParams.value.inviterUserId = route.query.inviterUserId ? Number(route.query.inviterUserId) : undefined
  queryParams.value.inviteeUserId = route.query.inviteeUserId ? Number(route.query.inviteeUserId) : undefined
  queryParams.value.inviteCode = route.query.inviteCode || undefined
  handleQuery()
}

function goUserDetail(userId) {
  proxy.$router.push({
    path: '/ai/user',
    query: {
      userId,
      detailUserId: userId
    }
  })
}

if (route.query.inviterUserId) {
  queryParams.value.inviterUserId = Number(route.query.inviterUserId)
}

if (route.query.inviteeUserId) {
  queryParams.value.inviteeUserId = Number(route.query.inviteeUserId)
}

if (route.query.inviteCode) {
  queryParams.value.inviteCode = route.query.inviteCode
}

getList()
</script>
