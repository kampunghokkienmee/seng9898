# 某招牌麵館 - iPad Restaurant POS

这是一个可直接运行的高级版 iPad 餐厅 POS 网页系统，使用 React + Tailwind CSS + LocalStorage。

## 功能

- Staff Login / Manager Login
- 员工 Clock In / Clock Out
- Table 1-20 桌号管理：Available / Occupied / Reserved / Cleaning
- 菜单点餐：分类、图片、价格、Popular、Sold Out、搜索、数量调整、备注
- 当前订单：Subtotal、Service Charge 10%、GST 9%、Discount、Total
- Hold Order / Send to Kitchen
- KDS 厨房显示：New / Preparing / Ready / Served
- 收银付款：Cash / Card / PayNow / QR Pay / Split Bill
- 付款成功后生成 Receipt
- Sales 报表：今日销售额、订单数、平均订单、热卖菜品、付款方式统计、图表
- 员工管理：今日上班员工、打卡记录
- 后台菜单管理：添加、改价、删除、修改图片、Popular、Sold Out

## 登录

Staff PIN:

- Alicia Tan: `1111`
- Ben Lim: `2222`
- Chloe Ng: `3333`
- Daniel Koh: `4444`

Manager PIN:

- Manager: `0000`

Manager 可以进入 Sales、Staff、Menu 后台管理页面；Staff 只能使用桌台、点餐、KDS、收银和自己的打卡功能。

## 运行方式

这个版本是单文件 React/Tailwind 应用，React、Tailwind 和 Babel 通过 CDN 加载，不需要安装 npm package。

在 PowerShell 运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\dev-server.ps1
```

然后打开：

```text
http://127.0.0.1:4173/
```

也可以直接双击 `index.html` 打开，但建议使用上面的本地服务器，图片和 CDN 资源更稳定。

## 可点击 Demo 流程

这不是静态展示页，下面流程都可以真实点击测试，并会写入 LocalStorage：

1. 用 Manager PIN `0000` 登录。
2. 点击 `Table 1` 进入点餐。
3. 点击任意食物卡片加入订单。
4. 在右侧订单栏调整数量、删除菜品、设置备注或折扣。
5. 点击 `Send to Kitchen`，到 KDS 页面查看厨房工单。
6. 点击 `Cashier`，选择付款方式并点击 `Simulate Payment Success`。
7. 查看生成的 Receipt。
8. 进入 `Sales` 查看今日销售、热卖菜品和付款方式统计。
9. 进入 `Menu` 添加菜品、改价、改图片、删除或设置 Sold Out。

登录页和 Manager 顶部都有 `Reset Demo Data` / `Reset Demo`，可一键清空测试数据并恢复初始状态。

## 怎样改名字和菜单

### 改店名 / POS 名字

1. 用 Manager PIN 登录。
2. 点击左侧 `Setup`。
3. 修改 `POS / Store Name` 和 `Subtitle`。
4. 点击 `Save Store Settings`。
5. 登出后登录页和系统顶部会显示新的名字。

### 改员工名字 / 员工 PIN

1. 用 Manager PIN 登录。
2. 点击左侧 `Staff`。
3. 在 `Staff Directory` 里点击员工的 `Edit Name`。
4. 修改 Staff Name、Role、PIN。
5. 点击 `Save Staff`。

也可以在同一页新增员工或删除员工。`Setup` 页面也保留了同样的员工编辑功能。

### 改菜单

1. 用 Manager PIN 登录。
2. 点击左侧 `Menu`。
3. 左边可以添加新菜品：Food Name、Category、Price、Image URL、Popular、Sold Out。
4. 右边每个菜品可以点 `Edit` 改名字、价格、分类和图片。
5. 点 `Sold Out` 可以设置售罄，点 `Delete` 可以删除菜品。

图片可以用网络图片 URL，例如 Unsplash 图片链接。修改后会自动保存在 LocalStorage。

目前预设中餐菜单：

- 檳城福建面
- 葱油面
- 麻辣葱油面
- 福建炒蝦麵

## 数据保存

所有业务数据保存在浏览器 LocalStorage：

- 菜单
- 桌台状态
- 订单
- KDS 工单
- 付款和销售记录
- 员工打卡记录

LocalStorage key:

```text
aurora-ipad-pos-state-v1
aurora-ipad-pos-session-v1
```

需要清空测试数据时，可以在浏览器开发者工具里删除以上两个 LocalStorage key。
