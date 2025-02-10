專案數據取自 [UberEats 官網](https://www.ubereats.com/tw)，屬於 **UberEats 及其店家合作夥伴**，僅用於學習參考之用。在本日優惠方案下的九湯屋日本拉麵 中山林森店、21PLUS 京站台北店、兔寶寶漢堡店有完整商品數據可供瀏覽！

## 技術選型

本專案選用了多種現代技術，以下是主要技術選型及其原因：

- **TypeScript**: 提供靜態類型檢查，增強開發過程中的錯誤檢查與代碼可讀性。
- **Git Flow**: 採用 Git Flow 工作流，規範分支管理與合併流程，保持專案開發流程的一致性。
- **Dev Container**: 使用容器進行開發，保持不同開發環境間的一致性。

### 前端

- **Next.js**: 實現伺服器端渲染（SSR）和靜態頁面生成（SSG），提升網站 SEO 性能與加載速度。
- **CSS Module + SCSS + TailwindCSS**: 結合使用 CSS Module 及 SCSS 進行樣式管理，並搭配 TailwindCSS 開發樣式。
- **Jest + React Testing Library**: 用於單元測試，確保組件的正確性和可維護性。
- **Cypress**: 用於端對端（E2E）測試，模擬用戶操作，確保用戶體驗的一致性。
- **Next-Intl**: 搭配狀態管理及 cookie 分別為 SSR 與 SSG 頁面做國際化處理。
- **Apollo Client**: 
  - 與後端 API 通信，進行靈活的數據請求。
  - 使用 Apollo Client Cache 做全局狀態管理。

### 後端

- **Express.js + GraphQL**: 使用 Express.js 搭建 GraphQL 伺服器，靈活處理前端的數據需求。
- **MySQL**: 選擇 MySQL 作為關聯式數據庫，存儲結構化數據，並保證數據的一致性與可靠性。
- **MVC 架構**: 使用 MVC 架構進行解耦，將 Resolvers、Type Definitions 和數據獲取邏輯分開，保持代碼的可擴展性。

### 部署

- **Docker Compose**: 使用 Docker Compose 管理多容器服務，簡化開發與部署過程。
- **GitHub Actions**: 
  - 自動整合並執行程式碼規則檢測、單元測試、e2e測試、構建及上傳鏡像。
  - 自動部署合格程式碼到GCP Compute Engine。
    - [測試環境](http://34.122.84.197/)
    - [生產環境](http://34.29.43.187/)
