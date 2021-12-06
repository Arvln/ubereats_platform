本專案數據取自[UberEats官網](https://www.ubereats.com/tw)，屬於**UberEats及其店家合作夥伴**，僅用於學習參考之用！

## 啟用系統

首先，安裝docker，若使用MacOS系統請開啟終端機運行安裝命令

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install --cask docker
```

檢查docker-compose版本確認安裝是否成功

```bash
docker-compose -v
```

在專案根目錄運行啟動命令

```bash
docker-compose up -d
```

建立系統約需2~3分鐘，起來動一動泡杯咖啡，再運行命令查看是否已啟動，順利啟動後可收到啟動通知


```bash
docker logs web
#output
ready - started server on 0.0.0.0:3000, url: http://localhost:3000
```

大功告成，使用瀏覽器開啟 [http://localhost](http://localhost) 查看專案內容，詳細商品數據在本日優惠方案下的九湯屋日本拉麵 中山林森店、21PLUS 京站台北店、兔寶寶漢堡店有完整數據可供瀏覽！

## 技術架構

- 採用Typescript開發

### 前端

- 以Next.js建立SSR與SSG網頁渲染，優化網站SEO
- 採用Next.js推薦的CSS Module結合SCSS、TailwindCSS進行切版
- 以Apollo Client Cache做全局狀態管理
- 使用Apollo Client與後端API通信

### 後端

- 以Express.js建立GraphQL Server
- 採用MySQL作為關聯式資料庫
- 使用MVC架構解耦Resolvers、Type Defs與數據獲取，建立可擴展的數據流

### 部署

- 使用Docker Compose管理各項服務
