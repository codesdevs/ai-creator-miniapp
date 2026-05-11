# AI Creator MiniApp Development Plan

## Phase 1: Login and User Identity

### Goal
Build a real C-end identity system for the mini program and replace the current pure demo login path.

### Tasks
- Add WeChat mini program login flow: `uni.login()` on client and `/app/auth/wxLogin` on server.
- Introduce configurable WeChat credentials and environment switching.
- Unify app-side auth model around `DEV`, `WECHAT_OPENID`, and `WECHAT_UNIONID`.
- Complete login persistence, logout, profile initialization, and unauthenticated intercept behavior.
- Keep `devLogin` only as a development fallback.

### Deliverables
- WeChat login API and config scaffold in Spring Boot.
- Mini program login API wrapper and page integration.
- Stable app token lifecycle for C-end users.

### Dependencies
- WeChat mini program `appid` and `secret`.
- Redis and current app token service.

## Phase 2: Home and Model Consumption

### Goal
Turn the homepage into a real model selection and traffic distribution entry.

### Tasks
- Define homepage sections: recommended models, categories, balance card, and quick-create entry.
- Support model list filtering, detail display, and version selection.
- Pass `modelId` and `versionId` into creation pages.
- Add parameter forms per model version, including prompts, ratios, styles, and quantity.
- Add front-end validation for required fields and power-cost preview.

### Deliverables
- Structured homepage data model.
- Click-through flow from homepage to creation pages.
- Version-aware create form.

### Dependencies
- Existing model and version APIs.
- Wallet balance display and model metadata.

## Phase 3: Task Submission and Result Lifecycle

### Goal
Make task submission, queueing, polling, and result rendering complete and traceable.

### Tasks
- Normalize task states: `WAITING`, `RUNNING`, `SUCCESS`, `FAIL`.
- Expand submit API payload to support full creation parameters.
- Add client polling and failure reason rendering.
- Render multi-image or multi-result output in task detail and works pages.
- Support retry and "create again" from previous tasks.

### Deliverables
- Stable submit-and-poll task loop.
- Result detail page with status transitions.
- Reusable task/result DTO structure.

### Dependencies
- Phase 2 create form.
- Downstream AI provider integration or mock task engine.

## Phase 4: Wallet and Power System

### Goal
Make balance, deduction, refund, and grant behavior consistent and auditable.

### Tasks
- Complete wallet dashboard, flow list, and empty/loading states.
- Enforce transaction-safe task deduction and failure refund logic.
- Add admin tools for manual grant and user-level wallet inspection.
- Reserve recharge order and payment callback structure for later payment integration.

### Deliverables
- Reliable wallet balance update flow.
- Clear wallet ledger for user and admin sides.
- Recharge-ready backend table and service design.

### Dependencies
- Task lifecycle from Phase 3.
- Admin UI and wallet APIs.

## Phase 5: Admin Console Completion

### Goal
Make the RuoYi admin panel usable for daily content and operations management.

### Tasks
- Add model publish status, sort, cover, and recommendation fields into admin workflows.
- Add C-end user list, auth type, registration time, and usage statistics.
- Improve task management with filters, failure handling, and notes.
- Expand wallet operations with user-level search and aggregate statistics.

### Deliverables
- Operational admin screens for models, users, tasks, and wallet.
- Better filter and maintenance capabilities for internal staff.

### Dependencies
- Stable C-end data models from Phases 1 to 4.

## Phase 6: Release Readiness and Engineering Hardening

### Goal
Prepare the system for test deployment and later production rollout.

### Tasks
- Split local, test, and production environment configs for backend and mini program.
- Add network error states, retry affordances, and empty-state polish.
- Add basic app-side risk controls such as rate limiting, access control, and safer asset delivery.
- Build a regression checklist for login, create, task, wallet, and admin modules.

### Deliverables
- Environment-specific config strategy.
- Baseline release checklist.
- Hardened error handling and operational safety.

### Dependencies
- All prior feature phases.

## Current Execution Order

1. Finish Phase 1 WeChat login skeleton and keep development fallback available.
2. After Phase 1 is verified, move directly to homepage and creation flow in Phase 2.
