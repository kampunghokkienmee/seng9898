# seng9898 - 家鄉福建面 POS

這是從 `Phostop Downtown Done` 複製的獨立 POS 系統骨架。

## 已保留

- Staff / Manager 登入與權限
- 桌台、點餐、Hold Order、KDS、收銀與收據
- Sales、付款記錄、員工打卡、請假、Supplier
- Menu 與 Setup 後台，可從畫面新增分類和菜品
- Manager 在任何電腦或平板瀏覽器登入後直接顯示完整 POS，不需要特殊網址
- 手機版使用底部滑動導航，桌台、Menu 與後台頁面可在小螢幕查看及操作
- Android 列印橋接功能

## 已清空及隔離

- 預設菜單與分類皆為空，不包含原店菜品
- 登入頁與側欄使用全新的家鄉福建面蝦麵 Logo
- 使用獨立的 `seng9898-*` LocalStorage keys
- Cloud Sync 預設關閉，Firebase 設定為空
- 不會連接或修改原本 `Phostop Downtown Done` 的營業資料

## 預設登入

- Staff：`1111`
- Manager：`0000`
- Device Repair：`8888`

用 Manager 登入後，到 `Menu` 新增分類及菜品，到 `Setup` 修改店名、登入和 Cloud Sync。

普通 Staff 登入只顯示 KDS 與付款記錄；Manager、Boss、Big Boss 顯示完整點單與後台。

## 執行

直接用靜態網站伺服器開啟 `index.html`。例如：

```powershell
python -m http.server 4173
```

然後打開 `http://127.0.0.1:4173/`。
