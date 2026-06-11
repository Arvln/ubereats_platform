--
-- 資料庫: `ubereats_platform_local`
--

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET collation_connection = 'utf8mb4_unicode_ci';

DROP DATABASE IF EXISTS `ubereats_platform_local`;

CREATE DATABASE IF NOT EXISTS `ubereats_platform_local` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use `ubereats_platform_local`;

-- --------------------------------------------------------

--
-- 資料表結構 `Table_Structure`
--

CREATE TABLE IF NOT EXISTS `Table_Shop_Category` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(50) NOT NULL DEFAULT '',
  `name` char(50) DEFAULT '',
  `image_suffix` char(50) DEFAULT '',
  `is_cuisines` BOOLEAN DEFAULT true,
  `rank` int(10) NOT NULL,
  `uuid` BINARY(16) NOT NULL,
  PRIMARY KEY ( `id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Table_Advertise` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` varchar(1800) NOT NULL DEFAULT '',
  `image_suffix` char(50) NOT NULL DEFAULT '',
  `is_show` BOOLEAN DEFAULT true,
  `uuid` BINARY(16) NOT NULL,
  PRIMARY KEY ( `id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `Table_Shop_Channel` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(50) NOT NULL DEFAULT '',
  `subtitle` char(100) DEFAULT '',
  `image_suffix` char(100) DEFAULT '',
  `uuid` BINARY(16) NOT NULL,
  PRIMARY KEY ( `id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Table_Shop` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL DEFAULT '',
  `delivery_cost` int(3) DEFAULT 25,
  `shortest_delivery_time` int(3) DEFAULT 20,
  `score` int(3) DEFAULT 10,
  `discount_label` char(50) DEFAULT '',
  `image_suffix` char(50) NOT NULL DEFAULT '',
  `banner_suffix` char(50) NOT NULL DEFAULT '',
  `address` varchar(200) NOT NULL DEFAULT '',
  `uuid` BINARY(16) NOT NULL,
  PRIMARY KEY ( `id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Table_Good_Channel` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(50) NOT NULL DEFAULT '',
  `uuid` BINARY(16) NOT NULL,
  `shop_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY ( `id` ),
  FOREIGN KEY(`shop_id`) REFERENCES `Table_Shop`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Table_Good` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(100) NOT NULL DEFAULT '',
  `price` int(3) DEFAULT 0,
  `discription` varchar(900) NOT NULL DEFAULT '',
  `image_suffix` char(50) NOT NULL DEFAULT '',
  `spicy_level` char(50) NOT NULL DEFAULT '',
  `is_emphasis` BOOLEAN DEFAULT false,
  `is_discount` BOOLEAN DEFAULT false,
  `is_exclusive` BOOLEAN DEFAULT false,
  `is_show` BOOLEAN DEFAULT true,
  `uuid` BINARY(16) NOT NULL,
  `shop_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY ( `id` ),
  FOREIGN KEY(`shop_id`) REFERENCES `Table_Shop`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Table_Mapping_Good_And_Channel` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `good_id` int(10) UNSIGNED NOT NULL,
  `channel_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY ( `id` ),
  FOREIGN KEY(`good_id`) REFERENCES `Table_Good`(`id`),
  FOREIGN KEY(`channel_id`) REFERENCES `Table_Good_Channel`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Table_Mapping_Shop_And_Channel` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` int(10) UNSIGNED NOT NULL,
  `channel_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY ( `id` ),
  FOREIGN KEY(`shop_id`) REFERENCES `Table_Shop`(`id`),
  FOREIGN KEY(`channel_id`) REFERENCES `Table_Shop_Channel`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Table_Mapping_Shop_And_Category` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY ( `id` ),
  FOREIGN KEY(`shop_id`) REFERENCES `Table_Shop`(`id`),
  FOREIGN KEY(`category_id`) REFERENCES `Table_Shop_Category`(`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 資料表的資料 `Table_Dataframe`
--

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-promotions', 'Deals', 'deals.png', 0, 5, UNHEX(REPLACE('04bde584-3f40-5681-8cbb-046fe0e0087c', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-fresh-groceries', 'Grocery', 'uber_grocery.png', 0, 1, UNHEX(REPLACE('502b1466-39a8-52a4-a00d-cbfd87a044b5', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-convenience-stores', 'Essentials', 'convenience.png', 0, 11, UNHEX(REPLACE('37d4c872-05bf-5382-9932-f57966e06e5d', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-beauty-baby', '', 'beauty.png', 0, 22, UNHEX(REPLACE('ae770aba-e12a-5699-80b4-4e49eef75cc7', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-pet-supplies', 'Pet', 'pet_supplies.jpg', 0, 9, UNHEX(REPLACE('8f2b5d75-2d67-51fc-a6ce-e00470af2eca', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-fresh-flowers', 'Flowers', 'flowers.jpg', 0, 10, UNHEX(REPLACE('db014d72-d078-5b82-a9bf-dd0fa8602909', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-department-stores', 'Retail', 'retail.jpg', 0, 4, UNHEX(REPLACE('e0fca0b5-317b-55d1-a889-912a1fa463a7', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-curated-restaurants', 'TopEats', 'top_eats.png', 0, 14, UNHEX(REPLACE('26efd113-d5a6-5575-9a9c-d15bdbffcc10', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-bubble-tea', 'BubbleTea', 'bubbletea.png', 1, 2, UNHEX(REPLACE('77535355-0584-5a69-9bf5-8616d2c0b642', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-chinese-cuisine', 'Chinese', 'chinese.png', 1, 12, UNHEX(REPLACE('131cc30a-851a-5431-b39b-8b82f182b2f0', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-coffee-tea', 'CoffeeTea', 'coffeeandtea.png', 1, 8, UNHEX(REPLACE('c363f80c-74a4-5efa-8b05-80e93524d055', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-japanese-cuisine', 'Japanese', 'japanese.png', 1, 7, UNHEX(REPLACE('eb5ca398-1ee9-50eb-9f5f-45b739f446e8', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-desserts', 'Dessert', 'dessert.png', 1, 6, UNHEX(REPLACE('77789edc-66bc-5aaf-8622-83d6d7ffcf78', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-taiwanese-cuisine', 'Taiwanese', 'taiwanese.png', 1, 3, UNHEX(REPLACE('d45be114-6165-5f85-aae5-ff9f3cdde39b', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-thai-cuisine', 'Thai', 'thai.png', 1, 15, UNHEX(REPLACE('2478b613-2a18-5560-8f3b-2189836793ac', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-korean-cuisine', 'Korean', 'korean.png', 1, 20, UNHEX(REPLACE('fc663d86-fa82-5e17-8c34-32588802a282', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-bbq', 'BBQ', 'bbq.png', 1, 16, UNHEX(REPLACE('6dcbc77b-cc7a-5888-b4d3-be86b6cf1d21', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-healthy-eating', 'Healthy', 'healthy.png', 1, 21, UNHEX(REPLACE('c6fb88e2-d185-5ed9-8dd6-f22109283183', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-asian-cuisine', 'Asian', 'asian.png', 1, 17, UNHEX(REPLACE('86c17e97-b53d-5ca7-a77a-426b22741419', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-italian-cuisine', 'Italian', 'italian.png', 1, 18, UNHEX(REPLACE('48bef94c-b6f2-51f2-a2ac-f1f278cad92a', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-street-food', 'StreetFood', 'streetfood.png', 1, 13, UNHEX(REPLACE('e08c8f78-7b80-59c1-b548-148528adea2b', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-pizza', 'Pizza', 'pizza.png', 1, 23, UNHEX(REPLACE('0eed145b-4be5-5734-8111-fcad2ae780c3', '-', '')));

INSERT IGNORE INTO `Table_Shop_Category` (`title`, `name`, `image_suffix`, `is_cuisines`, `rank`, `uuid`) VALUES ('categories-breakfast-and-brunch', 'Breakfast', 'breakfast.png', 1, 19, UNHEX(REPLACE('184ceb12-c16d-527a-a318-53e936270bc8', '-', '')));


INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('今晚，我想來點平價食尚！

即日起至12月31日，新用戶輸入「平價食尚」，即可享 2 次訂單金額滿 299 元折抵 150元 優惠，手刀打開 Uber Eats，平價美味的食尚風格，讓你天天吃不膩！ 🍕🥘🍨🍱


⚠️ 「平價食尚」優惠序號 注意事項 ⚠️
*「平價食尚」優惠序號，優惠內容為 2 次 150 元優惠折抵
* 新用戶指首次註冊成為 Uber Eats 會員且過去未使用 Uber Eats 消費過者
* 本優惠外送費亦有適用
* 商品金額須滿 299 元方可使用
* 商品金額指扣除外送費及使用其他優惠序號折抵優惠的商品小計金額
*「平價食尚」優惠序號，限台灣 Uber Eats 營運範圍使用
* 本優惠可與優饗方案疊加使用
* 優惠期限為 2021/10/14 - 2021/12/31，根據 Uber Eats 針對每個優惠序號（「平價食尚」）設立的附加條款於適用法律所允許之限度內，Uber Eats 自己（或所合作的商家合作夥伴）可能決定發行優惠序號以作為帳戶之回饋或其他有關本服務及／或第三方運輸提供商所提供服務的功能或利益。優惠序號之規定請參照Uber Eats 使用者條款之規定
* Uber Eats 保有對本優惠之所有解釋、修改、調整、終止等相關權利
* 此優惠不得與其他優惠併用，若有任何疑問，請利用 App 內建幫助功能回報問題
* 你在此同意且承諾不會以違反法律、法規或其他不正當方式使用本優惠，如經發現，Uber Eats保有調整或終止前開優惠之權利', '205fe9d1-7530-4442-9143-02ae1e7193dd.jpeg', 1, UNHEX(REPLACE('b5b5ad3e-4be0-5545-8462-f67a5390e22e', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('【來點好食在的...Uber Eats 獨家 Subway 滿額贈優惠！】

10/ 20 至 11/2，選擇 Subway 活動餐廳

不吃醃黃瓜？想要多生菜！你想要的好料，SUBWAY 通通加好加滿 🎉🎉。點餐滿 $249 即贈 兩片餅乾 🍪 🍪！

⚠️注意事項 ⚠️
* 活動期間為 2021/10/20 - 2021/11/02
* 需手動將活動所贈送之餐點加入購物車，符合活動滿額門檻後餐點金額會自動折抵
* 贈送餐點以每間指定活動餐廳菜單內標示之公告訊息為主，每日數量有限送完為止
* 每筆訂餐最多可獲得活動單品一份
* 贈送餐點不包含客製化加價項目，加價項目需依加價商品數量另外付費
* 實際販售品項依各店內菜單為主
* 優惠數量有限，送完為止
* 本活動優惠可與優饗方案及其他優惠序號同時使用
* Uber Eats 保有對本活動之所有解釋、修改、調整、終止等相關權利，其詳細辦法、變更事項或未盡事宜則以 Uber Eats App 內公告為主。若對此優惠有任何疑問，請利用 App 內建幫助功能回報問題', '1938621e-91e3-4e68-8857-4dbf1c3328c0.jpeg', 1, UNHEX(REPLACE('9d11bd8e-16a1-5a2a-917a-7db5bc2a8e61', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('【大苑子滿額贈優惠！】

11 /17 至 11/23，選擇大苑子活動店家
點餐滿 $249 即贈 台灣鮮搾柳橙綠！

新鮮台灣柳橙加上茉香綠茶完美調和，幸福的滋味，就在 Uber Eats !

⚠️注意事項 ⚠️
* 活動期間為 2021/11/17 - 2021/11/23
* 需手動將活動所贈送之餐點加入購物車，符合活動滿額門檻後商品金額會自動折抵
* 贈送商品以每間指定活動商家菜單內標示之公告訊息為主，數量有限送完為止
* 每筆訂餐最多可獲得活動單品一份
* 贈送商品不包含客製化加價項目，加價項目需依加價商品數量另外付費
* 實際販售品項依各店內菜單為主
* 本活動優惠可與優饗方案、雙享方案及其他優惠序號同時使用
* Uber Eats 保有對本活動之所有解釋、修改、調整、終止等相關權利，其詳細辦法、變更事項或未盡事宜則以 Uber Eats App 內公告為主。若對此優惠有任何疑問，請利用 App 內建幫助功能回報問題', '537aa947-275b-455d-94be-7bf4bcf2b085.jpg', 1, UNHEX(REPLACE('dfb532d8-923c-5348-a569-c14d0c764adb', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('
【可不可熟成紅茶線上獨家新品，就在 Uber Eats ! 】

11/3 起至 11/30，可不可熟成紅茶新品 - 紅寶歐酪於 Uber Eats 線上獨家開賣啦 🎉

👉🏻  優惠序號【可不可40】已兌換完畢，已兌換但尚未使用優惠者，不要猶豫！立即下訂，療癒新品，馬上到手💕  

⚠️ 注意事項 ⚠️
*「可不可40」優惠序號，優惠內容為訂單金額消費滿 $199 折抵 $40 優惠 (共 1 次)
* 訂單金額須滿 $199 方可使用
* 訂單金額指扣除外送費及使用其他優惠序號折抵優惠的商品小計金額
* 本優惠序號僅限使用於可不可熟成紅茶活動店家
* 本優惠序號數量限量，兌換完畢為止
* 本優惠可與雙享方案、優饗方案疊加使用
* 優惠期限為 2021/11/03 - 2021/11/30，根據 Uber Eats 針對每個優惠序號（「可不可40」）設立的附加條款於適用法律所允許之限度內，Uber Eats 自己（或所合作的商家合作夥伴）可能決定發行優惠序號以作為帳戶之回饋或其他有關本服務的功能或利益。優惠序號之規定請參照Uber Eats 使用者條款之規定
* Uber Eats 保有對本優惠之所有解釋、修改、調整、終止等相關權利
* 此優惠不得與其他優惠序號或滿額折優惠併用，若有任何疑問，請利用 App 內建幫助功能回報問題
*你在此同意不得以任何違反法律、法規或其他不正當方式使用本優惠，如經發現，Uber Eats保有對優惠調整或終止之權利', '6f792175-0d7d-4b64-9d8e-526b009fffce.jpg', 1, UNHEX(REPLACE('3bb93134-0a9a-582f-a4a3-50c455930019', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('【人氣名店感恩回饋 💗 會員獨享多一點：折抵 $70 優惠】

即日起至11/30，至上千間人氣名店點餐滿 $299

會員獨享 折 $70！
一般用戶 折 $40 !

垂涎三尺的美味，盡在 Uber Eats！ 
⚠️注意事項 ⚠️
* 活動期間為 2021/11/17 - 2021/11/30
* 滿額折為滿額優惠折抵，折抵金額以APP內指定活動餐廳顯示為主
* 本活動之會員優惠僅限訂閱優饗方案/雙享方案之會員輸入使用 (需正在訂閱者)
* 優饗方案/雙享方案新訂閱者至遲於 48 小時後得使用本優惠
* 優惠數量有限，送完為止
* 本活動不需輸入優惠序號，須於購物車頁面選擇本優惠，優惠折數以各餐廳顯示為主
* 除優饗方案/雙享方案外，本活動不得與其他優惠併用
* Uber Eats 保有對本優惠之所有解釋、修改、調整、終止等相關權利，未盡事宜則以 Uber Eats App 內公告為主', 'a958ddbc-b7d7-47dc-9bad-59cc28329d26.png', 1, UNHEX(REPLACE('20e68b0b-5b67-5e8c-b52f-f77ddea795fb', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('
【Uber Eats 五週年城市尋飽專車】🚚🚚🚚

以「平價食尚」、「限量美食」、「時尚生鮮」三大主題精心打造「五週年城市尋飽專車」，民眾到現場找到 Uber Eats 五週年尋飽專車就有機會獲得 Uber Eats 好康三重送。

📍 時間：11月20、21日 11:00 – 19:00
📍 地點：高雄市左營區博愛二路757號(高雄巨蛋前廣場)


●送週年優惠：新用戶下載 Uber Eats App 並輸入活動現場指定優惠序號，即可獲得2次「美食外送」單筆訂單滿300元現折250元折抵優惠，及1次「生鮮雜貨」單筆訂單滿100元即享5折優惠(單筆訂單最高折抵150元)，使用期限至2021年12月31日止。

●送限量美食：新用戶現場輸入指定優惠序號並即刻下單，出示下單成功畫面即可兌換1份猜心泡芙「五週年城市尋飽專車」所在地排隊名店限量美食。
●送Uber Eats專屬提袋：與尋飽專車拍照打卡，上傳FB或IG公開分享照片並標註「#UberEats」或「#UberEats生日快樂」，即可獲得1只品牌專屬不織布提袋。', '646e3d67-3f1f-4039-b8a1-cd10d842471a.jpg', 1, UNHEX(REPLACE('8f613aba-19be-5ca6-b90d-da10da78d8f7', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('7-ELEVEN 服務再擴大❗️

7-ELEVEN 於 Uber Eats 上擴大展店，
更多店家選擇，讓你輕鬆享受 CITY CAFE、御飯糰、零食飲料，隨點即送！
☕️🍙🍝🥤🍿🍬🧻💄🧼🧴

⚠️ 注意事項 ⚠️
* 商品實際供應情況以 APP 內顯示為主
* 實際販售品項依各店內商品為主', '0601e51e-23e5-42d6-a1aa-b936936f1550.png', 1, UNHEX(REPLACE('f50f409a-2438-5707-8ea0-980833212bbe', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('加入優饗方案/雙享方案，除了無限次 $0 運費折扣，再享以下優惠：

1. Uber Eats會員專屬餐廳優惠，加入優饗/雙享會員訂餐省更多，會員獨享多一點！
2. 即日起至 10/31，輸入「獨享外帶」，享外帶自取訂單 7 折優惠（共 3 次），單筆最高折抵 $100
3. 即日起至 10/31，輸入「獨享生鮮」，享生鮮雜貨訂單 7 折優惠（共 2 次），單筆最高折抵 $100！

⚠️ 「優惠序號」注意事項 ⚠️
* 本優惠序號僅限收到者使用，不得轉發及/或轉售
* 本活動之優惠序號僅限訂閱優饗方案/雙享方案之會員輸入使用 (需正在訂閱者)
* 優饗方案/雙享方案新訂閱者至遲於 48 小時後得使用本優惠
* 本優惠可與優饗方案疊加使用
* 優惠期限為 2021/10/01 (00:00) - 2021/10/31 (23:59)，根據 Uber Eats 針對每個優惠序號（「獨享生鮮」、「獨享外帶」）設立的附加條款於適用法律所允許之限度內，Uber Eats 自己（或所合作的商家合作夥伴）可能決定發行優惠序號以作為帳戶之回饋或其他有關本服務及／或第三方運輸提供商所提供服務的功能或利益。優惠序號之規定請參照Uber Eats 使用者條款之規定
* Uber Eats 保有對本優惠之所有解釋、修改、調整、終止等相關權利
* 此優惠不得與其他優惠併用，若有任何疑問，請利用 App 內建幫助功能回報問題
* 你在此同意且承諾不會以違反法律、法規或其他不正當方式使用本優惠，如經發現，Uber Eats保有調整或終止前開優惠之權利
* 訂單金額指扣除外送費及使用其他優惠序號折抵優惠的商品小計金額
* 限台灣 Uber Eats 營運範圍使用
- 商品準備完成後，若超過一個小時未取餐，商家合作夥伴則會回收商品，以確保商品品質及食品安全
- 若 App 內無自取選項，請更新 App 後重新開啟即可使用自取服務
\
⚠️ 「獨享生鮮」注意事項 ⚠️
*「獨享生鮮」優惠序號，消費不限金額即可享 7 折優惠，單筆最高折抵 $100，每人至多使用 2 次
* 限指定生鮮雜貨商家使用(若有適用，結帳時系統將自動帶入優惠)
\
⚠️ 「獨享外帶」注意事項 ⚠️
* 「獨享外帶」優惠序號，僅限於消費者選擇自取服務者使用，優惠內容為 7 折 3 次優惠折抵，單筆最高折抵上限為 $100
- 本優惠僅適用提供自取服務之商家合作夥伴，詳情以App內容為準
- 外帶自取服務需綁定信用卡付款，無法使用現金付費
', 'ce7967f4-1020-4b2d-b5d1-a785bfd2ce37.jpeg', 1, UNHEX(REPLACE('2d63bdc0-65a2-5407-a988-497bba66a533', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('【來點好食在的...上千道熱夯美食買一送一！】

10/20 起至 11/02，於活動餐廳選擇指定商品，即享買一送一！

排骨便當、鹽酥雞、排隊手搖...700 家餐廳、1400 道人氣美食買一送一！必吃台味，澎湃吃起來！

⚠️注意事項 ⚠️
* 活動期間為 2021/10/20 - 2021/11/02
* 本優惠活動，買一送一餐點，數量有限，售完為止
* 活動期間每人於每家指定活動餐廳僅限使用本活動乙次，即僅限於該家指定活動餐廳取得買一送一餐點優惠乙次
* 活動內容為每兩個活動單品可享一個免費，以此類推每四個單品則兩個免費。惟活動單品訂購數量若為奇數，則僅有成對部分享有優惠，例如，每五個單品則兩個免費
* 買一送一活動不包含客製化加價項目，加價項目需依加價商品數量另外付費
* 各別餐廳優惠不同，以各別餐廳實際優惠情形為主
* 本活動優惠可與優饗方案及其他優惠序號同時使用
* 本活動之品項金額不納入其他優惠折抵之計算
* Uber Eats 保有對本優惠之所有解釋、修改、調整、終止等相關權利，未盡事宜則以 Uber Eats App 內公告為主', '14a68fc5-6944-442f-94b1-1cf2be8c5d2f.jpeg', 1, UNHEX(REPLACE('30c57144-37cb-51d8-aca6-eaa12967cd1b', '-', '')));
INSERT IGNORE INTO `Table_Advertise` (`content`, `image_suffix`, `is_show`, `uuid`) VALUES ('【排隊名店，熱銷招牌菜都在這！火紅單品優惠 7 折起】

10/20 起至 11/2，訂購指定餐廳商品，皆享折扣優惠！
會員獨享 7 折！
一般用戶 8 折！

 Eats 吃好料，折扣享不完！ 

⚠️注意事項 ⚠️
* 活動期間為 2021/10/20 - 2021/11/02
* 滿額折為滿額折抵，折抵金額以APP內指定活動餐廳顯示為主
* 本活動之會員折扣僅限訂閱優饗方案/雙享方案之會員輸入使用 (需正在訂閱者)
* 優饗方案/雙享方案新訂閱者至遲於 48 小時後得使用本優惠
* 折扣數量有限，送完為止
* 本活動不需輸入折扣序號，須於購物車頁面選擇本折扣，折數以各餐廳顯示為主
* 除優饗方案/雙享方案外，本活動不得與其他優惠併用
* Uber Eats 保有對本折扣優惠之所有解釋、修改、調整、終止等相關權利，未盡事宜則以 Uber Eats App 內公告為主', '3f5f5207-631f-4360-a657-704264570a1a.png', 1, UNHEX(REPLACE('5d54b698-459f-54fc-9fa3-0af1fe48acad', '-', '')));


INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.buy-1-get-1-free-offer', '', '', UNHEX(REPLACE('e05ce9a6-d5d7-5368-b258-443be2ba0a93', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.today-special-offer', '', '', UNHEX(REPLACE('336e60d8-f952-5f5b-aeca-3ba4fb321e7b', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.nationwide-famous-brands', '', '', UNHEX(REPLACE('653eb667-9ffd-576a-86ff-d89078bc2481', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.healthy-meals', '', '', UNHEX(REPLACE('097c5179-89d2-55ec-87a6-430cf6c73e23', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.explore-by-category', '', '', UNHEX(REPLACE('af4922f3-4636-525f-a108-e5067748c788', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.curated-restaurants', 'channel.high-quality-delivery-restaurants', 'd4p17acsd5wyj.cloudfront.net/eatsfeed/carousel_icons/carousel_icon_top_eats.png', UNHEX(REPLACE('aa06306a-a197-5765-8077-be20e579e5e3', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.family-friendly-restaurants', '', '', UNHEX(REPLACE('458fea90-3402-5b90-8085-b55302d8b5a3', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.popular-merchants-near-you', '', '', UNHEX(REPLACE('3cc51fae-80ab-5ba0-b7d2-b27db842e5c5', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.in-a-hurry', 'channel.fastest-delivery-service', '', UNHEX(REPLACE('5e125676-6dc2-503e-a35b-06dd3285b12d', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.no-service-fee-for-pickup', 'channel.choose-pickup-to-avoid-this-fee', 'd4p17acsd5wyj.cloudfront.net/eatsfeed/pickup-homefeed-carousel/pickupcarousel_icon@3x.png', UNHEX(REPLACE('d2c13373-6eff-5eac-be75-97ee029cf7a8', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.loved-by-locals', '', '', UNHEX(REPLACE('c4ba9f57-a6d2-5fcb-81fe-b1b0ea552f42', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.the-latest-ubereats-partner-restaurants', 'channel.be-among-the-first-to-support-them', '', UNHEX(REPLACE('ced80487-59ae-5e4a-9d35-12f75dd67f17', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.your-rewards', '', 'duyt4h9nfnj50.cloudfront.net/eatsfeed/cheerios_rebrand_carousel_aligned.png', UNHEX(REPLACE('5d737d0a-982a-5784-bc44-7d5d1e9bcd98', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.treat-yourself-well', '', '', UNHEX(REPLACE('79c74d64-d37d-549d-aa0f-68025be4b9cd', '-', '')));
INSERT IGNORE INTO `Table_Shop_Channel` (`title`, `subtitle`, `image_suffix`, `uuid`) VALUES ('channel.allergy-friendly-restaurants', 'channel.restaurants-accommodating-food-allergy-special-needs', '', UNHEX(REPLACE('9aa57161-c0dc-552e-b9ba-bdcd17b9d754', '-', '')));


INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('九湯屋日本拉麵 中山林森店', 40, 15, 47, '買1送1', '52282d1b-0ed6-4453-b297-c7d3a59b95ff.jpeg', '3d1d9b7a-05e4-429f-82ab-b83d3b6c3b53.jpeg', '台北市中山區南京東路一段132巷33號, Taipei, 104', UNHEX(REPLACE('555af249-6a62-575c-ac06-099c8771f7d6', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('21PLUS 京站台北店', 25, 35, 47, '訂購指定餐點即享折扣優惠', 'ae7bebda-9c56-4ed1-ab48-39f515e5ea80.jpeg', '58df0c5d-3831-4618-bfa4-389990766421.jpeg', '103, Taiwan, Taipei City, Datong District, Section 1, Chengde Road, 1號b2, Taipei City 103', UNHEX(REPLACE('81bcccba-21c4-55ec-9913-82793bedd107', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('兔寶寶漢堡店', 50, 15, 100, '免費餐點 (消費 $200)', '3082d6a1-f590-4f9d-af53-d4e6f6e6687c.jpeg', '7fbaf726-1a5c-44d9-b727-41fad1541210.jpeg', 'No. 9, Lane 115, Section 2, Minsheng East Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('1b559e6d-7278-5241-9c70-fd2a2475a0ce', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('茗香園冰室 中山店', 25, 30, 47, '訂購指定餐點即享折扣優惠', '4ec17365-8f90-4136-adf7-8f658d1a29b6.jpeg', 'c08038e7-1119-4d5a-846f-9fc01d3e73b5.jpeg', '103, Taiwan, Taipei City, Datong District, Lane 18, Nanjing West Road, 6號2號樓之1, 103', UNHEX(REPLACE('85144203-c90d-52d5-9c3e-09bcbb09cdcf', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('咖啡瑪榭中山店', 30, 25, 100, '買1送1', '1f8933bc-9916-4ac5-a43f-a057f211f8ce.jpeg', '4d38c811-25bc-4eec-aff9-58776ee3b548.jpeg', 'Zhongshan North Road Section 2 Lane 16 15, Zhongshan District, Taipei City 104', UNHEX(REPLACE('cc5755d5-0dfa-5d3b-b8f2-dbd75d390121', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('欣葉日本料理 中山店', 30, 25, 47, '訂購指定餐點即享折扣優惠', '4fa18f2b-43d7-443f-ab81-d225b7b21faf.jpeg', '35249950-8e80-4cbc-89ea-57beaad7532b.jpeg', 'No. 52, Section 2, Zhongshan N Rd, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('23456aef-6dc8-5e9d-89c5-88f439e69a09', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Subway 京站店', 40, 25, 47, '免費餐點 (消費 $249)', '40c04703-0a2f-4283-8ec4-53ce20704268.jpeg', '3822c4dd-fd51-49a9-96ea-897978945769.jpeg', '103台灣台北市大同區承德路一段1號, B2, 台北市 103', UNHEX(REPLACE('c4ba37b9-4ab5-5d3c-b604-97476100067b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('廚坊早午簡餐', 55, 30, 47, '訂購指定餐點即享折扣優惠', '295972d6-f74f-4587-809a-7b9a3b147a57.jpeg', '39808148-e0c1-41ec-9f32-c99b33c0cd00.jpeg', 'No. 43, Lane 145, Chenggong Road, Sanchong District, New Taipei City, Taiwan 241', UNHEX(REPLACE('95e477b6-4650-526c-94ad-b6a79643457b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('蘭芳麵食館', 55, 40, 100, '買1送1', 'f7a8d9d8-bbb6-4f0e-8012-d057db911eb0.jpeg', '23c66fbc-6d27-4cc5-898c-7f99b83da0b0.jpeg', 'No. 95, Liaoning Street, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('f36facab-20ed-55e5-96f9-4106cb847505', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('忠青商行', 45, 25, 48, '買1送1', '8a0b1b0e-132b-40c9-856e-e96c82b8fbde.jpeg', '07ea3afd-629a-4cbe-99fd-2baba2b03733.jpeg', 'No. 6, Qingdao East Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('964304d1-6221-5d84-8fc5-322d05c342db', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('東京咖哩Tokyo Curry (台北林森店)', 30, 15, 48, '買1送1', '905ac9fd-0807-4aa2-ad62-09a7b3277af3', 'd1c6e16c-5095-45c0-bf02-a9948d9b9020', 'No. 96-4, Linsen N Rd, Taipei City 104', UNHEX(REPLACE('566b9969-a908-5f6f-ba45-9ab937546067', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('白暮蛋餅先生 1號店', 55, 30, 100, '買1送1', '4e26ed83-a754-4b27-b8f9-fb44d527e933.jpeg', '70870dc9-36a9-4185-9c5f-b795c525f94c.jpeg', '台北市松山區敦化北路244巷39號, Taipei, 105', UNHEX(REPLACE('45a2ecea-b778-52fa-b0ef-04886eb55889', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('8+9蓋飯 烏龍麵', 40, 15, 47, '買1送1', 'd5e2f3ab-44d8-47cf-b8ea-44c56f5ab01b.jpeg', '17922385-55d3-4b10-9893-bcbc1bc990cd.jpeg', 'No. 28, Lane 96, Section 2, Zhongshan North Road, Zhongshan District, Taipei City, Taiwan 10491, Taipei City 104', UNHEX(REPLACE('88dcd459-0207-538c-988a-5e644729cfb7', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('大心 泰式麵食 台北微風車站店', 30, 25, 49, '', '60cea9ce-0613-45d8-8b0e-af0a94e396bb.jpeg', 'bd7180e6-0e96-4539-83e3-be4d9f259a3a.jpeg', '100, Taiwan, Taipei City, Zhongzheng District, Beiping West Road, 3號2樓, 北2門上2樓, 100', UNHEX(REPLACE('b5bee250-ecda-5073-aa5a-cd35858d5e26', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('麥當勞 S206北民生三 McDonald''s Ming Sheng III, Taipei', 40, 5, 49, '', '454783b0-c1fc-462a-b1cc-96cc4d62fcc1.jpeg', '1d3c77d8-29f6-4713-851f-37f1f3aef05d.jpeg', 'No. 55, Minsheng West Road, Datong District, Taipei City, Taiwan 103', UNHEX(REPLACE('476bd9aa-5497-53b3-996b-690ba0eb6d91', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('肯德基 KFC 台北雙連', 40, 20, 48, '', '69c02606-e9ea-4f00-afc9-f94e773fbdba.jpeg', 'd118bfc0-7dae-4d09-906d-317f40af17f5.jpeg', '10491台灣台北市中山區民生西路9號, Zhongshan District, 104', UNHEX(REPLACE('2eb6722c-97c7-56ef-8c96-c267e03f337a', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Burger King漢堡王 欣欣店', 35, 15, 46, '', '4945bb68-48ff-4414-bb42-e39186ec3218.jpeg', '11517066-c2c6-43ca-b652-bd429210013e.jpeg', '台北市中山區林森北路247號1f, Taipei, 104', UNHEX(REPLACE('4994d1c8-dd3c-5a23-8ad7-c4e3453e46d5', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('必勝客 Pizza Hut 圓環外送店 (Pasta Hut義大利麵)', 35, 20, 48, '', '93a1142a-c39e-4b8e-a717-43c056b6f420.jpeg', '2617676c-e441-422b-a13a-1c87ac1ec871.jpeg', '台北市大同區重慶北路1段108號, Taipei, 103', UNHEX(REPLACE('3289e520-c9ce-5648-a885-8dba81257506', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('STARBUCKS星巴克 南京西門市', 30, 10, 48, '', '8b1b4782-f1ad-4b94-8819-bd198f5158ab.jpeg', '289c38f6-280f-4f43-9b31-844d60217458.jpeg', '台北市大同區南京西路 36號1f, Taipei, 103', UNHEX(REPLACE('36c918b1-7929-5ffa-b12c-7ff0c0d08ac9', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('胖老爹重慶圓環店', 40, 20, 48, '', '5974335a-aa14-4e6e-9dfd-ad723abcda08.jpeg', 'dfaa0800-79c4-498f-a155-75188a65031c.jpeg', '101, Section 1, Chongqing North Road, Taipei City 103', UNHEX(REPLACE('f0efb48f-8a0a-5a72-89d2-db2462a8fcd9', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('拾貳食 Midday Meat', 55, 20, 48, '', 'f826f767-e0ce-448e-a28f-3d9724493ded.jpeg', 'd67013bd-3e19-4188-bc3c-e89d3f789d92.jpeg', 'Linyi Street Lane 19 11, Zhongzheng District, Taipei City 100', UNHEX(REPLACE('74b3583a-934d-5706-9ffe-e22307b5a5a0', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Peeta Take Take 長安店', 45, 15, 100, '', 'c7cdf93d-aa5f-4b45-9256-d93e577a0ed9.jpeg', 'b35b33ff-5c32-4cc0-8d10-3ac8339a1ee5.jpeg', 'Lane 35, Section 2, Chang''An East Road, Zhongshan District, Taipei City, Taiwan 104 ', UNHEX(REPLACE('cead2a23-c2a8-5dca-8101-4361d6d2ba3c', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('The Soup Spoon Taiwan 匙碗湯 BREEZE 微風北車店', 35, 20, 45, '', '0d9d003f-cd0f-4e04-b9be-a40654292630.jpeg', 'c104db0c-12e1-413f-b0ac-d5876d63072b.jpeg', '100台灣台北市中正區北平西路3號, 2樓北二門, 台北市 100', UNHEX(REPLACE('45c224b6-23d4-56c9-bca6-326fa70a34b5', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('裸食 By Naked Bistro', 55, 30, 100, '', 'fe87a2d2-7ef5-4b83-8db9-3eecae588d85.jpeg', 'e1dc3ed9-7a11-44c2-9fef-52abc53bf354.jpeg', 'No. 8, Lane 165, Dunhua North Road,Songshan District, Taipei City, Taiwan 105, Taipei City 105', UNHEX(REPLACE('b28ecc49-3627-5ecd-afe9-2796de0f92d7', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('蔬坊The Greenery 誠品南西店', 30, 10, 48, '', 'a959a94d-4d5c-4524-b835-1a08e0d8b6ce.jpeg', 'afa6e4a3-14fb-4bac-ad3c-2e0564a98cb7.jpeg', '台北市中山區南京西路14號b1, Taipei, 104', UNHEX(REPLACE('3bc48eff-d8bb-5e33-8ec1-34c9fd18245b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('盒心肌群', 35, 15, 49, '', '90f7106f-c70e-4b2a-8c52-83ad81143135.jpeg', 'a5efb3f8-f921-4d60-80d5-dce073990daf.jpeg', '台北市大同區承德路一段77-2號', UNHEX(REPLACE('236fc54a-950a-5b57-9215-bcc85cc609bb', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('GET POWER 給力盒子 低脂健康餐盒 馬偕店', 40, 15, 100, '', 'faabd29d-2a9e-4fa0-b5b1-198fedd33d45.jpeg', '2434090a-045b-4755-9294-0cfadcce3dd5.jpeg', 'No. 7, Section 1, Minsheng East Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('0fd4eae1-5b0b-5e5c-9e76-2f0f8d682755', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('平成日式煎餃', 50, 15, 100, '', '3e2bffd7-7e52-4be1-ba38-8a969a65cff0.jpeg', '59de48df-8ac3-4e51-9bc8-06c149614221.jpeg', 'No. 20, Nanyang Street, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('498018d4-405f-511f-8488-5e333fdd9ef3', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('漁曜海物斑魚火作', 35, 30, 100, '', '6ce171b4-2285-4b42-b3e0-4351e29d47f5.jpeg', 'cfb26248-b7af-45be-879c-5f48563b68a4.jpeg', 'Taiyuan Road Lane 152 15, Datong District, Taipei City 103', UNHEX(REPLACE('54e7c657-8757-546b-8b20-cafb5d59a103', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Kitchen Island 中島', 55, 20, 100, '', '2195655e-f562-4d27-94f3-ea4d97621392', 'e0eca8d8-a89b-44b4-9c8f-b2e0215a5315', 'No. 12, Lane 276, Section 3, Zhongxiao East Road, Da’an District, Taipei City, Taiwan 106', UNHEX(REPLACE('111eb49d-0dee-5ba5-9873-1b33178ce99c', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('雙寶美味早午餐', 55, 30, 100, '', '638f7633-be3d-45b4-84c2-1d4893520f75.jpeg', 'a1452d07-e421-411f-8674-92cba9bc5c10.jpeg', 'No. 183, Longmen Road, Sanchong District, New Taipei City, Taiwan 241', UNHEX(REPLACE('aa766a85-061e-5b9a-921f-dcf836bf90dc', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('五燈獎豬腳魯肉飯', 55, 20, 100, '', '277399fd-cd7f-421b-b57b-b39423457872.jpeg', '93ac2bf7-86df-4138-be13-5c781b77465f.jpeg', 'No. 119, Section 1, Ziqiang Road, Sanchong District, New Taipei City, Taiwan 241', UNHEX(REPLACE('27b6c6b8-0529-5c5a-97ea-6e9e2cb876c0', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('有煎餃子館 寧波館', 55, 30, 49, '再 3 份訂單即可獲得 $90 獎勵', '38555009-b911-40b6-bae2-c33587321538.jpeg', '4a9bca67-f971-4c9d-8a82-d32a5547e05b.jpeg', '台北市中正區寧波西街7號, Taipei, 100', UNHEX(REPLACE('a8f3ed5f-9692-5566-b019-ba7f7a4d1c68', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('有煎餃子館 忠杭店', 45, 25, 48, '再 3 份訂單即可獲得 $90 獎勵', 'a9759de2-76ac-4afc-9cef-a2c1818cc5de.jpeg', '6fca9a89-4dce-44df-ab36-e509daabb5f4.jpeg', '100台北市中正區杭州南路一段10之1號, Taipei, 100', UNHEX(REPLACE('84ceb374-0ab2-5c56-898c-e304408121c2', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('呷尚飽 復華店', 55, 35, 50, '', '7120e88b-d5f2-473b-99ef-1de46245b415', '22cf7595-245a-4629-be11-2977e6c57fa1', '台北市中正區新生南路一段144-9號, Taipei, 100', UNHEX(REPLACE('1d9c9a59-8e74-5e5e-8144-6d226d78bb6e', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('彭園 創始店', 30, 25, 100, '', '8458a4c5-f654-4fa7-90c1-3e1ce35cd0e5.jpeg', '5468bf43-1552-4018-b94d-9b93caf5afb4.jpeg', 'No. 380, Linsen North Road, 2F, Taipei City 104', UNHEX(REPLACE('f4f9da16-cf29-54de-94c7-3a1eba2ffc1c', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('三五水餃', 40, 10, 100, '', '8ca6b37d-39f3-476e-9965-d72b11e4474a.jpeg', '737b9ae6-e57a-4ac5-8f2d-0c68abe497d6.jpeg', 'No. 17, Minsheng West Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('5a12d3f3-8ef4-5eef-b9f3-054b53f891f6', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('楊記大餛飩 黃巾珍珠奶茶專賣店', 55, 25, 46, '', 'ec620745-5288-4b8b-b209-840ae0d657b4.jpeg', 'a6948d49-9f94-4343-903c-a743d7ed4e4e.jpeg', '台北市中正區八德路一段82巷9弄8號, Taipei, 100', UNHEX(REPLACE('7505715a-cc15-5bc9-ae8f-dea6d10f07cb', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Coco Brother 椰兄 南京店', 55, 30, 47, '', 'ce624271-1ad3-4cc7-a332-06f33d322dfa.jpeg', 'f6e42022-11a2-441e-86e8-fc0eaa8667a5.jpeg', 'No. 24, Lane 303, Section 3, Nanjing East Road, Songshan District, Taipei City, Taiwan 105', UNHEX(REPLACE('82b86dd1-d0e6-5701-ab55-a8671549004d', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('周胖子 龍江店', 55, 20, 49, '免費餐點 (消費 $300)', '2f86e496-9da8-4887-8500-99be149f9638.jpeg', '40d0dce4-e1fa-4cb0-8848-b9ed79a9fcb0.jpeg', '台北市中山區龍江路116號, Taipei, 104', UNHEX(REPLACE('affd8bfc-d187-54b6-b41d-36d8c7433f84', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('馬修嚴選 南京門市', 40, 15, 50, '', 'f7a9e759-5f5b-4539-8257-507cec72d771.jpeg', '343d37b1-6db8-40e5-9ad0-05578871b59e.jpeg', '台北市中山區南京東路二段38號, Taipei, 104', UNHEX(REPLACE('7c3f7e64-b599-5fb6-bc5b-922f592b60ee', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('米玥麻糬堂 台北大安店', 55, 20, 48, '', '6842a3f8-636d-4c78-8f5a-bc1bb826f69a.jpeg', 'ffc4d064-5044-455f-b8fa-a499ffa16d6f.jpeg', 'Da-An Road Section 1 22, Da''An District, Taipei City 106', UNHEX(REPLACE('4f862126-bd0a-516d-8acd-5f9c3305d5e9', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('MoMoParadise 台北中山牧場', 30, 30, 47, '', '4964c5b9-94c5-4df3-90cf-723e271dd890.jpeg', '05c139db-2c6f-4f6f-aa55-5f5bc112b97e.jpeg', '台北市中山區南京西路6號2樓, Zhongshan District, 104', UNHEX(REPLACE('5a79e0ff-1c8b-55c3-97a0-0ca74a7d0600', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('艋舺原汁排骨湯', 55, 15, 100, '', '90016950-f066-407d-8cd2-b254562eced8.jpeg', '2595268d-cc61-4fb5-a124-525e6e6a5120.jpeg', '90 Lane 410, Section 2, Bade Road, Taipei, APACX 105', UNHEX(REPLACE('eb760684-7705-511b-b9a1-092beae1a6dd', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('五桐號WooTEA 伊通店', 55, 15, 100, '', '5062fc15-42ac-4803-af54-64d77816250f.jpeg', 'c62a870d-aefc-4da9-97ee-ad3e5d5f7cd9.jpeg', 'Yitong Street 97, 1號, Zhongshan District, Taipei City 104', UNHEX(REPLACE('0c66f855-aa47-5fe6-9d35-0a47d805f9ee', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('龍涎居好湯 中山安東店', 55, 25, 49, '買1送1', 'd94b48a1-6597-4b34-a0c7-7c90c1713b81.jpeg', '03f459e7-b208-4e0f-9ef6-67d144c364d9.jpeg', '台北市中山區安東街2-2號, Taipei, 104', UNHEX(REPLACE('c871eaec-b2ac-5114-92dc-c56174b922ca', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('珍煮丹 台北濟南店', 55, 15, 49, '', '2239eba6-3905-4d04-901f-86978b1855ed.jpeg', '4a5cc548-8851-4b60-af55-d8ae84afa456.jpeg', 'No. 60, Section 2, Jinan Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('3bd0a01b-c3f1-5454-bb98-88751f5e1fc8', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('傳統美食暨小南門傳統豆花  誠品南西店', 30, 15, 48, '', '5dca3cb9-dc8b-404d-8e79-15fc87893398.jpeg', '238b7fa3-409a-4814-b916-1541417fb38a.jpeg', '10491台灣台北市中山區南京西路14號, B1, 台北市 10491', UNHEX(REPLACE('3107b68b-297f-5944-83c5-6b2cf1f12ff7', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('麥當勞 S077林森三 McDonald''s Lin Sen III, Taipei', 45, 5, 49, '', '454783b0-c1fc-462a-b1cc-96cc4d62fcc1.jpeg', '01fd217b-6c62-452c-a615-d63bf11ad399.jpeg', '413, Linsen North Road, Zhongshan District, 104', UNHEX(REPLACE('1f8dabae-e59b-57b6-bfc0-b36bd2d4b0ac', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('GET POWER 給力盒子 低脂健康餐盒 一江店', 45, 5, 100, '', '09d08111-1fa3-46e2-beb4-3aaa6aef7735.jpeg', '6dbd2ba9-152b-499c-b8d8-818df954edcc.jpeg', '台北市中山區一江街10號之1, Zhongshan District, 104', UNHEX(REPLACE('52bf4741-b275-54ea-b28c-8253d101e4b0', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('libo cafe', 35, 5, 100, '免費餐點 (消費 $300)', 'f1f33183-c536-474d-be03-0b1f532fc067.jpeg', '9878f799-6263-4da3-b743-5ab47b075956.jpeg', 'No. 12, Lane 42, Section 2, Zhongshan North Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('604de16f-7df4-5018-8a4b-c47094f68a9f', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('双連古早味現烤蛋糕', 40, 5, 100, '', 'df5b238a-0f03-4823-8c47-e5155494a7c2.jpeg', '6b74daf2-a0b7-45b8-b980-6525602bad25.jpeg', 'No. 103', UNHEX(REPLACE('f55b5bc2-89f7-50da-834a-08bf91ffa4aa', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Hala Chicken 中山南西店', 30, 5, 48, '', '45eae219-d4da-4ea9-a5e1-a7952cd8d6ab.jpeg', '2cc9ef6f-e6ed-43f2-8085-f7185e460351.jpeg', 'Zhongshan North Road Section 1 Lane 140 49, Zhongshan District, Taipei City 104', UNHEX(REPLACE('44b32d03-aec5-589b-a9aa-55be096ee413', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('小馬辣個人鍋・滷味  中山店', 0, 20, 47, '', '2aa5cb7d-8b71-4635-84a8-ef93bf9f8cfe.jpeg', '5f74376e-1ddf-489b-9a9e-e19bd0c1dff8.jpeg', 'Nanjing West Road 22, B1(捷運中山站1號出口,牛乳大王旁B1), Datong District, Taipei City 103', UNHEX(REPLACE('ad29b6dd-9a32-5292-94c7-6d8b2669118d', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('夢鹿咖啡 by tame moose', 100, 10, 48, '訂購指定餐點即享折扣優惠', '48c312b4-3124-481c-a02a-0916277b84bc.jpeg', 'e747bbea-2ff9-4a03-8994-b60c5e9cb8fb.jpeg', 'No. 6, Alley 6, Lane 18, Nanjing West Road, 1F, Taipei City 103', UNHEX(REPLACE('89a236a5-2399-5e11-ad3c-83c2db3215ed', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('沐田No.2-1涮涮工廠', 100, 15, 49, '', '02e9089d-aa5b-42e1-8e09-e7dc94c3dadb.jpeg', '51cfb448-323f-4de9-999c-9ef186ac5a96.jpeg', 'Nanjing West Road Lane 25 2, 2-1號2樓, Datong District, Taipei City 103', UNHEX(REPLACE('a5b7302f-1cc9-5511-9f36-a3957ecda384', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('GALERIE BISTRO', 100, 5, 0, '', 'a7a73c8c-f09b-47dc-9ed2-788154c8d987.jpeg', 'b2069e59-3bed-4603-b584-856d048d0d98.jpeg', 'Nanjing West Road Lane 25 2, Datong District, Taipei City 103', UNHEX(REPLACE('8d8efeb8-5e0c-5189-a160-2d594ab11599', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Jumane Cafe 佐曼咖啡館', 100, 20, 47, '', 'b1f279b7-18b9-4cbd-b2f4-d4092107f4ad.jpeg', '/e22fb882-2184-45bd-a382-b8622f918dcc.jpeg', 'Zhongshan North Road Section 2 Lane 16 23, Zhongshan District, Taipei City 104', UNHEX(REPLACE('fe7db2f8-232b-569c-a96c-5879b5ed41b2', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('At.First  早寓', 55, 45, 100, '再 5 份訂單即可獲得 $250 獎勵', '7794cdbf-fd7e-4e10-bf5f-30f230087440.jpeg', '9293bf2a-1a42-48cc-b5de-5d225b6589d7.jpeg', '6, Alley 5, Lane 70, Yanji Street, Taipei City 106', UNHEX(REPLACE('2fa66c62-9478-590a-b8b1-b4946e106b97', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Buckskin Yakiniku 柏克金燒肉屋', 35, 20, 47, '', '11b24c6a-72ca-49ce-a445-aceac0ddd255.jpeg', '5bc4336d-19c1-4736-bbac-8395bed0b9c7.jpeg', '10491台灣台北市中山區南京東路二段1號, 1號2樓, Zhongshan District, 104', UNHEX(REPLACE('e4d50e44-3e15-5e34-8b2a-f3d0c24e08d9', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('UNCLESHAWN 燒肉餐酒館 二號店', 55, 30, 100, '', '4c6edea7-a5da-4e62-9192-21cabc34082d.jpeg', 'f71e6adf-e0d2-4d3e-83cf-179be3350ae6.jpeg', 'Dunhua South Road Section 1 Lane 236 19, Da''An District, Taipei City 106', UNHEX(REPLACE('71aed04a-56f7-5bc3-a51a-fa6f60cd7b46', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('初宅One House', 55, 35, 45, '免費餐點 (消費 $300)', '8c741760-5808-4c4b-a29c-b3f0c5905110.jpeg', 'd6795e5b-2d25-4667-be90-2e3d0976045d.jpeg', '台北市大安區和平東路二段175巷35號, Taipei, 106', UNHEX(REPLACE('9892e9f6-0a68-5a72-bcb6-019e21a945a3', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('雙城街夜市 永恩台南虱目魚', 50, 20, 46, '訂購指定餐點即享折扣優惠', '5d52985f-9351-4cdf-9905-e0bc1fe2ea57.jpeg', '7b2a710c-53fe-4645-8052-3113138014f9.jpeg', 'Shuangcheng Street Lane 18 20, Zhongshan District, Taipei City 104', UNHEX(REPLACE('19197dc3-e4fa-5d31-8fdc-3ec0f37d7b96', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('食都臭臭鍋', 55, 25, 46, '買1送1', 'f7068e03-f097-4b18-b6dd-8c433fe2d545', '1bd565c9-54dc-4da8-88cc-9091064cbab5', '台北市中山區龍江路356巷33號, 台北市 104', UNHEX(REPLACE('c5540a81-fc3e-5329-9fb3-1d15a6022323', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('柳橙王子蛋糕', 50, 15, 100, '', 'f379b730-387f-4433-9093-eb196800b766.jpeg', 'b710dd9c-a4ca-4d61-a36c-49b6013f9136.jpeg', 'No. 7, Lane 48, Section 2, Jinan Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('f231d399-7100-53cd-8784-7e5a2ae4fd7a', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('新田鰻味屋 中山店', 25, 20, 48, '', '5423fb3b-6c3c-4c4a-8905-82719ddb51bd.jpeg', 'adbf2de5-2c37-47ab-bc59-5da09b5ec977.jpeg', 'Zhongshan North Road Section 2 Lane 77 45, Zhongshan District, Taipei City 104', UNHEX(REPLACE('d33966d7-9ae2-5758-9c19-580174ce3622', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('統一超商 長中門市', 35, 10, 0, '', '20ae8407-f20e-47d5-9c2b-7ce3567b83e0.jpeg', '0b8b3b9d-a2ba-4b08-94c5-f5033ce41205.jpeg', '台北市中山區中山北路二段40-1號, Taipei, 104', UNHEX(REPLACE('c72daec3-4496-50a8-a498-c0c670acc229', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('日屋咖哩', 45, 20, 0, '免費餐點 (消費 $300)', 'd31890d0-c49e-4333-a3b3-d132bb41b485.jpeg', '1cc2da43-7686-4375-bed0-a96f31bb167f.jpeg', 'Fushun Street 9, Zhongshan District, Taipei City 104', UNHEX(REPLACE('35798078-28f9-56b8-85f6-838c52f06e03', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Watsons屈臣氏 新南京門市 S0464', 40, 10, 0, '', '57863d61-04f3-4779-bcda-ea0d7d4dd84c.jpeg', '37ac555d-63a8-4e81-adf4-f783d137d523.jpeg', '台北市中山區南京東路二段50號, Taipei, 104', UNHEX(REPLACE('09dd4d93-e199-5744-a8c3-7e86aadadf0e', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('一鍋接一鍋 忠孝新生店', 50, 25, 0, '買1送1', '8aac7fad-b44c-4c2e-b40b-fee5224a0dbc.jpeg', '014ef285-78f7-46fe-86ba-53dcf58b827b.jpeg', 'Linyi Street Lane 3 1, Zhongzheng District, Taipei City 100', UNHEX(REPLACE('942e514c-a23a-52ea-a430-26d602df4737', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Pho 越南料理 中山店', 55, 30, 0, '', '6961c268-a10d-4654-b81d-401bfbf786fc.jpeg', '9aea5245-a323-4a32-b2d4-ff1d3c519c54.jpeg', 'Xing-An Street 122, Zhongshan District, Taipei City 104', UNHEX(REPLACE('c9c59283-8fad-5f9c-b1e9-cb2dc40c757e', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('LONTALAE儂特利 仁愛店', 50, 20, 0, '', '044d8d73-d0cd-4d65-98f9-cdbaf0ed319a.jpeg', '1a4022c9-b5de-40af-9c97-43bb5a4aec17.jpeg', 'No. 8, Sec.1, Ren''Ai Rd. Taipei City, Taipei City 100', UNHEX(REPLACE('ad306cd4-16fd-5c99-bc36-bcb4cee2b8bc', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('嘉義第一名火雞肉飯 南昌店', 55, 40, 48, '消費滿 $299 即可省下 $40', '0d7937af-8120-4ee6-9af7-c6fd5d88e4bd.jpeg', 'b0d780a6-8785-4cf9-9115-3f58f10dd7df.jpeg', '南昌路一段72號, 中正區, 台北市 100', UNHEX(REPLACE('c9f59c63-274c-5c19-a1fb-4833b81e74f0', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('美味軒鍋燒麵 南京店', 40, 10, 0, '', '1f09c9c2-6dac-4a73-b5ba-a33b43896905.jpeg', 'ffd7c3a4-2ca5-4305-8583-d31b27d599b6.jpeg', '台北市中山區南京東路一段132巷3號, Taipei, 103', UNHEX(REPLACE('18719a02-89de-5aaf-9d76-ae7839427689', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('五桐號WooTEA 古亭店', 55, 20, 100, '再 5 份訂單即可獲得 $188 獎勵', 'bee2b78f-648a-47b2-93b5-26e63a62da01.jpeg', '40634ba3-ff84-4273-9fb1-48dc61b2278e.jpeg', '台北市大安區和平東路一段17號, Taipei, 106', UNHEX(REPLACE('b49482b8-8e4f-58db-b0f6-ea6a5cda2e23', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('瓷禧茶坊 南昌店', 55, 25, 100, '再消費 $1,000 即可獲得 $200 獎勵', '916746c1-888a-49c8-8131-86f5f2a354d0.jpeg', '903e8a4d-8b06-4108-8a81-87496d59d5d1.jpeg', 'No. 84, Section 1, Nanchang Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('56f4c946-1a22-5003-828b-255c77bedddb', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('cama café 民生松江店', 50, 15, 49, '再 5 份訂單即可獲得 $188 獎勵', '46c56bd8-f48a-4225-a1c7-0da7f0116af5.jpeg', 'a7065680-528e-4273-9deb-c0675c6380f4.jpeg', '台北市中山區民生東路二段133號, Zhongshan District, 104', UNHEX(REPLACE('8843f876-c36c-57c2-9a9c-97c2b1d66019', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('1996 台灣茶葉飲品專賣店', 50, 25, 47, '再 5 份訂單即可獲得 $200 獎勵', '4971b1e2-1110-4f39-ae12-493c4d8f5154.jpeg', '06f7f5b2-0c21-441e-a60e-d65f4a26cbec.jpeg', 'Chengde Road Section 3 25, Datong District, Taipei City 103', UNHEX(REPLACE('d4a80480-5041-543f-8198-fc26c7e6420b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('瑞麟美而美三重自強一店', 55, 25, 48, '再消費 $1,250 即可獲得 $188 獎勵', 'e798a942-efbb-4445-84b2-fc82dbb055bd.jpeg', '59c27dbb-3130-4ab3-8d9d-35baf9987daa.jpeg', 'Ziqiang Road Section 1 18, Sanchong District, New Taipei City 241', UNHEX(REPLACE('8d976a2c-ae4e-5079-a804-95c96494a8ab', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('鶴茶樓 寧波西店', 55, 25, 100, '再 3 份訂單即可獲得獎勵', '78fb7898-d4c7-4b8c-b007-df57c0ae89f0.jpeg', 'e1bf535b-1124-4919-9634-45dc19aee591.jpeg', 'Ningbo West Street 42, Zhongzheng District, Taipei City 100', UNHEX(REPLACE('128ff958-8604-581b-9d67-5e5fef7bf360', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('COMEBUY 忠孝東店', 45, 20, 49, '再消費 $1,000 即可獲得 $150 獎勵', '30284a42-f413-490a-895b-222ae0f21d9e.jpeg', '1f44d634-fbb1-445e-868a-8e497a92a021.jpeg', 'No. 11-2, Section 1, Zhongxiao East Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('2c0c8cec-a6de-5f43-8e7e-8e9fc88dfc3e', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('台ONE雞蛋糕專賣', 55, 25, 0, '', '2eb12e95-cc6c-4a08-b404-0bb463c954d8.jpeg', '3f275f12-29e5-46c4-a6e8-c07fc8ba1ecc.jpeg', 'Songjiang Road Lane 226 10, 1號, Zhongshan District, Taipei City 104', UNHEX(REPLACE('51bb905d-ead1-5549-b77d-47ad1e863024', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('羊毛與花 光點', 30, 10, 48, '再 5 份訂單即可獲得 $250 獎勵', '72b12b57-e200-4fd9-a9d0-cb2b4ea9e155.jpeg', '173109a1-ee54-44a2-8610-6940519b37f3.jpeg', 'Zhongshan North Road Section 2 18, 1 樓, Zhongshan District, Taipei City 104', UNHEX(REPLACE('217bda3d-eeed-50c8-9c88-3e598ce43aa6', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('胡桃鉗格子鬆餅', 25, 35, 0, '', 'd0743c40-5bc9-4c52-a551-6f87cff7e65f.jpeg', '019697a3-b045-40b9-97a7-0a22805cd095.jpeg', 'Nanjing East Road Section 3 Lane 223 55, Zhongshan District, Taipei City 104', UNHEX(REPLACE('fec5df99-8898-5af5-9797-05c52ae316fc', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('誠字號涼本舖 北科光華店', 55, 30, 50, '', '538c8864-1bc1-4895-9d74-50f1931b36dd.jpeg', 'aa9e34bb-5aa7-48ad-a607-e75f64df47a2.jpeg', 'Xinsheng South Road Section 1 1, 1樓, 北科光華館 綠光庭園, Da''An District, Taipei City 106', UNHEX(REPLACE('9475126e-1fe8-579a-bbea-6d08a450fd85', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('漫花時 石花凍豆花', 45, 15, 0, '買1送1', 'cdbd6f97-be04-426d-ab02-033e255c18f5.jpeg', '1c77dd3d-2110-4e91-9564-1bbc76ba925d.jpeg', '103台北市大同區迪化街一段8號', UNHEX(REPLACE('e5894753-6241-589a-a19d-d59884e62e01', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('吃光光', 55, 20, 48, '', '9e6bc9a6-2206-4bf2-ab84-c1fed223ba98.jpeg', 'd2f5c74d-0e72-40ab-a649-f21c40d83b4f.jpeg', 'Da-An Road Section 1 Lane 31 20, Da''An District, Taipei City 106', UNHEX(REPLACE('eb629774-925a-5b4e-98ba-15d84bbea2ee', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('REEDS Coffee & Bakery 中山店', 30, 20, 0, '', 'cff52ef6-c160-4f1a-8cad-bd103054ca40.jpeg', '7185c5a7-458b-4fb9-93d1-2a94ff890db0.jpeg', 'Nanjing West Road Lane 25 4-1, Datong District, Taipei City 103', UNHEX(REPLACE('11ab5dc4-41df-5e03-9f09-4fb108c2bd3c', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('晴光商圈 越南小吃', 50, 20, 47, '', '1afc7529-6d3a-49f3-b788-b5036b3fd8ca.jpeg', '1c2e187c-b8b4-4f3b-8220-22ac5d9aa03d.jpeg', 'Shuangcheng Street Lane 17 10, 10號之1, Zhongshan District, Taipei City 104', UNHEX(REPLACE('b08fff44-7acc-5a80-ac6e-38ffe42134c6', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('鍋鍋鍋 獨享鍋專賣店', 55, 25, 48, '', 'd539c171-5bd7-465d-bcfc-ddb2615ab048.jpeg', 'f618a60e-3c3a-4563-87f3-bb8975664578.jpeg', 'Bade Road Section 2 379, Songshan District, Taipei City 105', UNHEX(REPLACE('04186d42-7f2a-510e-9f5d-9c29abadb54e', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Lazyfood速食小農鮮奶', 55, 20, 48, '', '9ff5a748-6677-40f9-a666-8c2dd0c30b17.jpeg', 'cd6126c0-374e-4925-a28d-a1ec96442ccc.jpeg', '重慶南路三段71號, Taipei City, Taipei City 100', UNHEX(REPLACE('83030702-7421-55d4-8e85-f8d2d8b96790', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('OKEY COFFEE', 55, 30, 0, '', '6a2f1323-ea13-409b-b0da-da7b82e98f10.jpeg', '92e1bd0a-2a95-40f0-8423-9b1377bd54c0.jpeg', 'Fuxing North Road Lane 361 10, Songshan District, Taipei City 105', UNHEX(REPLACE('a14c7a4e-127e-5e12-8bf8-0e2d11847881', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('坂田家廚房', 45, 15, 49, '', '2eb24a65-d3ae-4b54-b325-52b96ec12b05.jpeg', 'a12467e9-fe7b-4ce6-a0c5-04b1c54946ed.jpeg', 'Qingdao East Road 4, 4-2號, Zhongzheng District, Taipei City 100', UNHEX(REPLACE('1a1cf476-f4e6-5930-a99e-c54246871661', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('霜 越南河粉 復興店', 55, 25, 46, '', '97143ba9-551e-4793-b7ba-589bbef409fa.jpeg', '70cb0951-80d6-488d-8844-3fc8f5403d5c.jpeg', 'Fuxing South Road Section 1 74, Da''An District, Taipei City 106', UNHEX(REPLACE('8877c840-7dcb-523c-915b-074497f04c56', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('麥當勞 S109台北民權 McDonald''s Min Cyuan, Taipei', 55, 15, 49, '', '454783b0-c1fc-462a-b1cc-96cc4d62fcc1.jpeg', '53e6694f-241d-4a28-917d-2f9aaf7dc14c.jpeg', '128, Section 3, Minquan East Road, Songshan District, 105', UNHEX(REPLACE('b1a449e2-bd3f-5d86-a080-5ba83f7811f7', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('MoMoParadise 台北復興牧場', 55, 35, 48, '', '5938c9b7-26b1-46d4-9456-8acf87a91ada.jpeg', '3b110934-1d68-4296-ae6d-9c96af5df86f.jpeg', '台北市大安區復興南路一段42號1樓, Taipei City, Taipei City 104', UNHEX(REPLACE('56cccb88-7be8-59df-92c7-560a2f6e30ff', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('愛爾蘭瘋薯 京站台北店', 25, 30, 47, '', '8314129a-2b69-499e-aeb7-18a58c387f00.jpeg', '8322f612-1401-404d-86e7-c7e48845ad9b.jpeg', '台北市大同區承德路一段1號, 4樓, Taipei, 103', UNHEX(REPLACE('78ff5f42-7090-51fa-849a-1bfb014cc5b7', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('鼎工坊', 55, 30, 47, '', '045be92f-6ed7-4a30-8623-bf9edbe7b51e.jpeg', '598398e4-69ff-4e63-b774-43caa713229d.jpeg', 'Dunhua North Road Lane 155 11, Songshan District, Taipei City 105', UNHEX(REPLACE('4c32896a-a625-5b56-858b-69eccff50a34', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('8+9蓋飯 烏龍麵', 40, 20, 47, '買1送1', 'd5e2f3ab-44d8-47cf-b8ea-44c56f5ab01b.jpeg', '17922385-55d3-4b10-9893-bcbc1bc990cd.jpeg', 'No. 28, Lane 96, Section 2, Zhongshan North Road, Zhongshan District, Taipei City, Taiwan 10491, Taipei City 104', UNHEX(REPLACE('7c8c4e17-5443-5057-81d4-c5f5917f829c', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('花茶大師台北四平店', 50, 20, 100, '買1送1', '46f75c68-9c1e-442d-a81c-624322128686.jpeg', 'b721f05e-9a9b-4219-910b-cf7030cdbafd.jpeg', 'No. 71, Siping Street, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('68cee6f5-76f8-5ab6-854f-d910244460d5', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('N.Y.Bagels Café 京站台北店', 25, 30, 48, '免費餐點 (消費 $500)', 'a01ed662-7917-4b5e-9473-48d47a19c6b3.jpeg', '0756b641-69c1-43be-ba0b-017192e5555c.jpeg', 'No. 1, Section 1, Chengde Road, Datong District, Taipei City, Taiwan 103', UNHEX(REPLACE('b856fdb5-f9b0-5538-95c0-add739698058', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('麥味登 北市國王', 45, 15, 49, '訂購指定餐點即享折扣優惠', '1b02a136-8008-4265-b925-61f7960d3141.jpeg', '028295de-ef70-42e8-a4fe-c749bed6c2b8.jpeg', '10491台灣台北市中山區民生東路一段5號, 1樓, 台北市 104', UNHEX(REPLACE('e607aa87-6531-5ce4-a8e8-f93185be3dca', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('世界豆漿大王 民族店', 55, 15, 100, '買1送1', '0b3acb78-944e-4012-8d14-1f16774f342b.jpeg', '4922fb1e-f309-4645-93c4-ecc21934c785.jpeg', 'No. 292, Minzu W Rd, Taipei City 103', UNHEX(REPLACE('0d615e7f-dd06-5c67-b8c2-3c0938d4b9f2', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('臥籠包子舖', 55, 30, 47, '免費餐點 (消費 $219)', 'f5a0a8a8-2865-4e30-9892-6467867c18ff.jpeg', '4a8182e8-f59c-42ed-96f0-706b86abdd0d.jpeg', '台北市中山區伊通街121號, Taipei, 104', UNHEX(REPLACE('691d5553-244a-594a-8ef4-84c757f2a15a', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('拉亞漢堡 北市延平南店', 50, 25, 47, '買1送1', 'ef3ccabb-fd42-4514-a950-39195eebd297.jpeg', 'faef1b1b-0fac-461c-a3c1-879eaab2a135.jpeg', 'No. 57, Yanping South Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('7d481590-728f-53b2-bdd8-7e191c2afa5a', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('彼得好咖啡 民生雙連店', 40, 15, 49, '免費餐點 (消費 $200)', '87a8412a-ba28-41a4-984b-50df57a61574.jpeg', '45586513-9b08-4f1f-9f09-9561d059a3e2.jpeg', '台北市大同區民生西路146號, Taipei, 103', UNHEX(REPLACE('4113fc3a-7277-5b9d-b260-175c1dd6b643', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('農安街水煎包', 55, 15, 47, '免費餐點 (消費 $200)', 'cdfe990b-d5cf-47d2-a163-782f4169ef18.jpeg', 'e12a176e-1ff3-4df2-acb4-656a8ef0e99d.jpeg', 'Minquan East Road Section 2 Lane 135 35, Zhongshan District, Taipei City 104', UNHEX(REPLACE('522488cd-cdd1-5a0d-b1e3-652a5a5c0d68', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('全聯福利中心 中山中安', 35, 15, 49, '', '7c1e18f1-1a55-429d-bec5-670bd0aa7bc6.jpeg', '949650df-fb41-44da-bf13-2da56b816f90.jpeg', '臺北市中山區中山北路2段59巷45號, B1, Taipei, 104', UNHEX(REPLACE('ec663237-6d1c-5b0e-94b3-909c635ca37d', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('家樂福 重慶店', 45, 25, 48, '', '7258d8c4-295b-4b14-89dd-a4b609cb9be7.jpeg', 'a1af2b79-b58c-47ec-aa92-73ffcbdb406a.jpeg', 'No. 171號, Section 2, Chongqing North Road, Datong District, Taipei City, Taiwan 103', UNHEX(REPLACE('ea4d9f70-8c4d-519e-802b-054f1faa89f8', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Uber Eats 優市 中山店', 55, 15, 49, '', '287331be-6369-4aa4-ba16-b0f4b9b16906.jpeg', '6a83f582-e253-48c6-9dbe-b0aa530046a1.jpeg', 'No. 120, Section 2, Jianguo N Rd, Zhongshan Districttaipei City, 10491', UNHEX(REPLACE('dfcb39a8-2254-5ad6-84cc-9033de223805', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('中山傳統市場', 35, 15, 48, '', 'a113287d-072c-4bd1-83c9-d2ce78b8c401.jpeg', '316554b6-9c0e-4dad-8458-cf1a0b72e58a.jpeg', '台北市中山區長安西路3號, Taipei, 104', UNHEX(REPLACE('a222d560-ed6a-572c-b27d-e5b677142099', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('大潤發 辛亥站 RT-MART', 55, 25, 48, '', 'd61e680d-6673-40c7-b818-8a2e70171a82.jpeg', 'c4637e19-0957-42c4-86ed-a08aa2c39e35.jpeg', '台北市大安區辛亥路一段70號, Taipei, 106', UNHEX(REPLACE('460cc5e8-74bd-5cb6-b6b3-45f9f5278390', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('南門傳統市場', 55, 50, 48, '', '15e3cb63-3a23-4beb-b0e5-56a14c7ce596.jpeg', 'defbd792-92c6-4d23-82ef-df593fe3467c.jpeg', '55號 Section 2, Hangzhou South Road, Taipei, APACX 106', UNHEX(REPLACE('6b6494b2-65c5-55a6-8c9c-75249f4a5354', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('家樂福超市 台北林森北店', 45, 20, 48, '', '74ebebf3-93ee-493b-87ef-c213b44fb9ee.jpeg', '6da98099-a607-42dc-82bd-b564d03a40c8.jpeg', 'Linsen North Road 413, B1, Zhongshan District, Taipei City 104', UNHEX(REPLACE('78b23808-1e4b-57fd-8b25-5dba03e5a6fa', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('統一超商 中錦門市', 30, 15, 0, '', '7bba79ba-4bec-4c84-bf00-bd41555f8efd.jpeg', '0b8b3b9d-a2ba-4b08-94c5-f5033ce41205.jpeg', '台北市中山區中山北路二段98號, Taipei, 104', UNHEX(REPLACE('0c514626-a69e-5640-8205-75edb516a71a', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('松江傳統市場', 50, 25, 47, '', 'f677007f-e1e7-470d-8bb9-107a90ccf951.jpeg', 'f5ec1845-7e8f-4dde-a1e5-7b0af660f089.jpeg', 'Jinzhou Street 222, Zhongshan District, Taipei City 104', UNHEX(REPLACE('147d21d0-21f1-5520-82f0-4e49c648ae16', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('萊爾富 3570北市雙蝶店', 30, 15, 0, '', '5dd1df00-f55e-46fe-9856-7ec4cd38f7e9.jpeg', '0994831b-cd96-4e7d-89f2-2c64ea59193e.jpeg', '台北市大同區南京西路64巷9弄2號, Taipei, 103', UNHEX(REPLACE('28c5932a-ef0a-5d1c-8622-bbd58de156ba', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Watsons屈臣氏 寧夏門市 S0639', 35, 20, 0, '', '0ee3c636-a89e-48df-947d-680b1e4e07b8.jpeg', 'f40fa26a-86fa-47f7-b6a5-93f7a0b2ac93.jpeg', '台北市大同區寧夏路9號, Taipei, 103', UNHEX(REPLACE('28fdeee2-0789-5677-89a8-f18f6d432150', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('TNR好事生活網', 55, 20, 0, '', 'efdc46b4-188e-42e8-902f-2e74bf15ed7d.jpeg', 'e2e7f0ef-7b3e-433a-b1ae-0468300ed634.jpeg', 'Yanji Street Lane 10 3, Songshan District, Taipei City 105', UNHEX(REPLACE('7671f06e-afe7-581a-b075-20f2a402e598', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Sundia桑迪亞花藝', 55, 35, 50, '', '566a3d51-5651-46f1-8254-47c370ddfaf7.jpeg', '6c90e144-77c9-4cf0-b342-8fcbbb2a8407.jpeg', 'No. 26, Lane 31, Section 1, Da''An Road, Da’an District, Taipei City, Taiwan 106', UNHEX(REPLACE('e3620a7b-1ff3-5bb5-948b-1d109642fc61', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Chic ô Fleurs 希朵花藝設計', 55, 50, 47, '', 'cc080618-c8e6-466b-bc5a-67ce0b8d8913.jpeg', '1348cd8b-e89c-4470-8f11-bf25194a74b4.jpeg', '台北市大安區復興南路一段279巷30弄3號, Taipei, 106', UNHEX(REPLACE('967c8579-c059-5865-be75-3011429c5015', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('佳瑪百貨 三重店', 55, 25, 0, '', '5a764b17-e2e2-47a1-a493-c2990683acd1.jpeg', '0cb9cbaa-f208-4182-8ecd-240c6cc57227.jpeg', '新北市三重區自強路一段73號1樓, Taipei, 241', UNHEX(REPLACE('999bd048-30e0-5cc5-b1f5-a9d3eba2af53', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('亞尼克 台北民生店', 55, 25, 100, '', '85d0099c-c142-4924-a3c7-3c078f932271.jpeg', '3fda17b3-fa51-47a2-b215-b86a929fea2b.jpeg', 'No. 61, Section 4, Minsheng East Road, Songshan District, Taipei City, Taiwan 105', UNHEX(REPLACE('790d02a0-d4b5-5d93-b046-47621283556b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('裕珍馨 台北南京旗艦店', 55, 25, 49, '', '0f7985fb-6d98-477c-adea-8a2747460e37.jpeg', '00ce6248-97d1-4278-8d1f-08e24c2d9123.jpeg', '台北市松山區南京東路四段180號, Taipei, 105', UNHEX(REPLACE('6900e12b-2897-5710-8149-978c433bae82', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('聖瑪莉 東門店', 55, 20, 48, '', 'dcf037c6-01f1-4669-a323-c7a541cbc835.jpeg', '3cc5473f-a8ef-4ddc-93f4-3bb5274bb188.jpeg', '台北市大安區信義路二段186號 ( 永康街口 ), Taipei, 106', UNHEX(REPLACE('65a4d4db-d291-5117-8a08-aad8cb4d9f9b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Semeur聖娜現烤麵包(錦西門市)', 40, 20, 48, '', '2e7ddac6-16a7-44b5-88cf-9410118088e8.jpeg', '958b7dd5-85ef-4773-b1f3-ff5bb533285b.jpeg', '台北市中山區錦西街18號, Taipei, 104', UNHEX(REPLACE('da648599-331a-5fd7-9d52-b3a4e9f87e6a', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('iVegan Cafe 植感咖啡廳', 55, 15, 49, '', 'd617f053-5dfd-408a-8e03-75c3ff5c3756.jpeg', '1b7d94bb-b90e-447e-bbad-b3b91bbb871a.jpeg', 'Linsen North Road 615, 3樓, Taipei City, Taipei City 104', UNHEX(REPLACE('be0b2276-508e-5808-8740-c2b013509683', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('五桐號WooTEA 開封店', 45, 25, 100, '買1送1', '2e704b95-44b9-40ca-9e42-b5301166f077.jpeg', '30f5d915-b2c7-4952-8e65-ac72f4071c14.jpeg', '台北市中正區開封街一段19號, Taipei, 100', UNHEX(REPLACE('55d1e55f-8253-552b-a498-dfd6b45bb5de', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('MACU麻古茶坊 林森店', 40, 20, 49, '', 'c44d7aa0-39c5-4aa7-920f-0dda94146350.jpeg', '4cb78d7e-a1cb-4c7b-bbf0-a5f3acb71beb.jpeg', 'Changchun Road 31, 1樓, Zhongshan District, Taipei City 104', UNHEX(REPLACE('f106b38d-42ac-556c-a309-89fb341027c3', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('可不可熟成紅茶 中山南西店', 30, 10, 50, '', 'c36a9a03-4310-4ca9-ae74-d2f764f8707c.jpeg', 'c28ee205-2d72-4266-87dc-f872348ba990.jpeg', '台北市中山區中山北路一段140巷13號1樓, Taipei, 104', UNHEX(REPLACE('5c96a88c-baa2-5168-9cef-e014924c4a6b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('迷客夏 Milk Shop 台北南陽店', 45, 30, 48, '', 'a8cafca4-2761-4211-a3a9-75c07ae80182.jpeg', '71d8261b-fbad-40ea-a950-7a4b1431e2ad.jpeg', 'No. 15-5, Nanyang Street, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('b121647a-e841-5d48-ab77-62cf9cc7fbe0', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('萬波 台北中山店', 40, 20, 48, '', 'dcd5cd39-9787-436c-9db9-14d4a61164d6.jpeg', '4b1a44a6-e099-4320-9fed-6961127d0bb4.jpeg', '台北市中山區中山北路二段52之1號, Taipei, 104', UNHEX(REPLACE('f3e49dca-bf42-53d5-a926-5a865acc95a6', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('天仁茗茶 中山店', 30, 10, 49, '', 'd0807379-1977-410b-8765-108aa9a58620.jpeg', '214ff2de-8655-4a26-b5a0-e15e9aab815a.jpeg', 'No. 11, Lane 105, Section 1, Zhongshan North Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('8641140f-9ade-584d-81e2-1f0a1f998912', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('龜記茗品 南西店', 35, 10, 49, '', '2cf6aaf9-6216-467b-b08e-5c3adcf1725d.jpeg', 'd1c6bc58-7e7c-49a8-9b0a-da9fa4f3c3f9.jpeg', 'No. 6, Lane 18, Nanjing West Road, Datong District, Taipei City, Taiwan 103', UNHEX(REPLACE('2e26e248-4f75-5c16-a56c-4134831ea444', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('珍煮丹 台北濟南店', 55, 20, 50, '', '2239eba6-3905-4d04-901f-86978b1855ed.jpeg', '4a5cc548-8851-4b60-af55-d8ae84afa456.jpeg', 'No. 60, Section 2, Jinan Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('731131ee-e9ef-5621-a8de-2f357fa94c3c', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('台灣壽司郎 台北林森店', 35, 30, 46, '', 'b2b5af11-9206-40f9-accb-46e15c950467.jpeg', '87021a2b-c2d1-491e-89bc-9d532563272e.jpeg', '台北市中山區林森北路247號b1, Taipei, 104', UNHEX(REPLACE('496bf287-562b-5bf8-8231-f921ae2e1ee8', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('初鰻', 35, 30, 47, '', '93606106-e114-4361-bf87-9366a4402720.jpeg', '00c58aaf-5808-48cb-9ab6-c4e6cad63036.jpeg', 'No. 28號, Lane 13, Shuangcheng Street, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('4b8d62c5-eaa6-5f94-8c94-f67b4964ec83', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('爭鮮迴轉 林森店', 35, 20, 48, '', 'cd9cb460-52ca-4da3-ad9a-b624fe5d126c.jpeg', 'bd672b5b-bf05-4d2f-b254-c694ff667919.jpeg', '10491台灣台北市中山區中山北路二段45巷35號, 台北市 104', UNHEX(REPLACE('d42ee8e9-17fb-505f-a0b8-aac8830ffdf0', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('すき家 SUKIYA 民權西路店', 45, 15, 49, '', '3f7fde5f-99af-4065-92db-fbd050a094f1.jpeg', 'fc1bba12-431e-4253-a708-ee4bfb1b7648.jpeg', '台北市中山區民權西路75號, 1樓, Taipei, 104', UNHEX(REPLACE('2d5b7fea-7787-5782-a5a6-3b44711e3f0a', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('順億鮪魚專賣店 長安店', 25, 15, 47, '', '7a9ad452-cb70-41d9-a2ce-df53db10f9ff.jpeg', 'c60967bd-e826-411c-9910-3c44bc930588.jpeg', 'No. 47-3, Chang''An West Road, Datong District, Taipei City, Taiwan 103', UNHEX(REPLACE('0c448248-07cb-5bf5-8c3d-9360ab6be9c0', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('小原田 永康店', 50, 30, 100, '', '655b51cc-36c5-44fb-a128-0492adcaff78.jpeg', '0537f9be-5652-4433-bde7-7c1bd6893c30.jpeg', '台北市大安區永康街2巷1號, Taipei, 106', UNHEX(REPLACE('ec8e5e64-66a6-5821-ad93-865343f7faeb', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('美觀園 台北城老舖 日本料理', 45, 30, 100, '', 'f14a0b91-2985-48b1-9824-993f7163a6e0.jpeg', 'db031891-6c33-45dd-847f-8af46bdd6164.jpeg', 'Emei Street 36, Wanhua District, Taipei City 108', UNHEX(REPLACE('6f00ccbd-a2d6-55f5-ab71-499a8ef66405', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('杏子豬排 台北凱撒店', 35, 25, 47, '', 'd3640285-069f-43cf-8914-df13054ceadf.jpeg', 'c2dc7a2b-716e-4c91-8a2e-e4d04aa1167e.jpeg', 'No. 38, Section 1, Zhongxiao West Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('e4bf37ce-559c-5fef-8a51-b3556eabe7ed', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('多田壽司屋', 55, 25, 100, '免費餐點 (消費 $300)', 'cbba594d-715c-40ed-b5af-d965867e724b.jpeg', 'a6fa18a2-2cdd-41ca-8e88-d8dab79c4b00.jpeg', 'No. 6號, Lane 216, Section 3, Nanjing East Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('a145f53e-0ee9-5c44-adda-b99f4aaa55e4', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('量鐵板燒', 45, 20, 100, '買1送1', '0bc42af6-5b0a-464f-adc1-dfce2491072a.jpeg', 'dc8f1a81-a242-4862-b397-0876532f194c.jpeg', 'Zhongyuan Street 118, Zhongshan District, Taipei City 104', UNHEX(REPLACE('f1463857-0c27-5346-b249-2aa9f979355d', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('大橋頭老牌筒仔米糕', 45, 15, 100, '', '56279729-5c61-499f-b6ad-fb18ef911810.jpeg', 'bceb7634-8970-4062-8243-07f5df176f93.jpeg', '台北市大同區重慶北路2段113號一樓, Taipei, 103', UNHEX(REPLACE('e96763ec-abbf-5761-8a4a-7af1ab98d8be', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('君悅排骨 衡陽直營店', 45, 20, 48, '', 'd627b992-4061-4535-9f19-50a14d78119f.jpeg ', 'ef38c2fa-7826-49ca-ab80-c788221ad215.jpeg', '台北市中正區衡陽路37號, Taipei, 100', UNHEX(REPLACE('8f2f672e-f660-5e35-8746-5ddfa23d5f0b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('金峰魯肉飯', 55, 20, 47, '', '6f51de77-88f7-4186-baeb-04eb42eb067e.jpeg', 'c1f40884-88d9-45c6-a485-ac719fcfe6a8.jpeg', '100台灣台北市中正區羅斯福路一段10號, 之2, Zhongzheng District, 100', UNHEX(REPLACE('95128895-95b0-5897-b004-52380d1c2887', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('金仙魚丸店 四平店', 50, 15, 47, '', 'ba9ee080-9062-44be-acf5-31bbb75e0211.jpeg', '1b886e1a-8e6e-447a-9130-dd3083a0caea.jpeg', 'No. 1, Alley 3, Lane 115, Section 2, Nanjing East Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('64671b8f-3045-527e-8426-1987b7bb49b9', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('陽春麵店', 45, 25, 100, '買1送1', '81dd8624-4694-422f-bd4f-79b068cdfa0f.jpeg', 'cd4e0c3c-c480-4db5-a181-a82a4841d04b.jpeg', '104台灣台北市中山區吉林路121號, 台北市 104', UNHEX(REPLACE('7fbd87f2-48ca-5d1e-97dc-dd7513103d2b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('鬍鬚張 美食文化館', 40, 20, 48, '', '5a035b36-b234-4611-a597-a98520d2fbce.jpeg', '9772ef96-1a0f-4426-84d6-fafe14ae21e9.jpeg', 'No. 62, Ningxia Road, Datong District, Taipei City, Taiwan 103', UNHEX(REPLACE('24473fbe-d71f-58af-a8bb-24ea0224e19e', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('大埔平價鐵板燒 吉林店', 45, 25, 47, '', '68f5369b-a6c6-48e4-a09b-7614a10a4a02.jpeg', 'f368a006-3d0f-4317-b558-d85754d44217.jpeg', 'No. 176, Jilin Road, Zhongshan District, Taipei City, Taiwan 104', UNHEX(REPLACE('def3636a-4bee-5c88-b169-2a8d43d38d9b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('雙月食品社 濟南店', 40, 40, 100, '免費餐點 (消費 $300)', '29f0b2ba-d1af-49df-9c62-5aa29aaffc81.jpeg', 'f5019e15-940c-4da7-b3b2-7f5763b5f10d.jpeg', 'No. 7, Section 1, Jinan Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('5570d527-b3db-5fed-b480-f22ddbe7d577', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('生活在他方', 55, 25, 100, '', '403e78e9-0ce5-4558-8720-1ec2a1da2772.jpeg', '10705a29-d423-41f2-845e-8ed8ef143076.jpeg', 'Roosevelt Road Section 1 Lane 119 3, Zhongzheng District, Taipei City 100', UNHEX(REPLACE('851503cf-be04-5511-ba0f-8e016fc5be23', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('豆花莊', 45, 10, 100, '', 'f947dd55-d382-418d-a5b2-c75392ec0737.jpeg', 'a3556f77-bba3-40b9-a607-9d35dfbb5151.jpeg', '台北市大同區寧夏路49號, Taipei, 103', UNHEX(REPLACE('ba9ad998-2198-52f2-8096-e615d32c55dc', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Gelovery gift', 55, 25, 100, '訂購指定餐點即享折扣優惠', '860aa386-75a2-4827-95b3-348c4d8e63c7.jpeg', '67bbd92e-abfc-4b28-8ce9-713cdb33015a.jpeg', 'Da-An Road Section 1 Lane 51 27, Da''An District, Taipei City 106', UNHEX(REPLACE('19d92e0b-f467-5905-b79d-f4cc3a583830', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('摸摸桃子洋菓子', 35, 10, 100, '', 'aa1cb39b-84d2-4066-992f-de1f1773f25b.jpeg', '4c3f324b-5fc0-4274-82cf-f583bc7b3431.jpeg', '中山北路二段77巷8-6號, Taipei City, Taipei City 104', UNHEX(REPLACE('ee9aaf6f-7b49-550c-91a9-988c2a1c4637', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('羊毛與花 金華', 55, 25, 48, '買1送1', 'd3ed9b71-98c5-4ac0-bda9-44e5261ec733.jpeg', '2216fa78-ea5f-41a5-b9ad-6bfdba8e601b.jpeg', 'Jinshan South Road Section 2 134, 134-1號, Da''An District, Taipei City 106', UNHEX(REPLACE('c6113c27-9ab5-59f5-82a3-2dd45c1c963c', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Hoo Donut 呼點甜甜圈', 55, 20, 100, '', 'e823450d-afae-43b8-81d0-6358dc29312b.jpeg', 'e671b48b-503d-4565-8e0c-498b48315a5f.jpeg', 'No. 7-2, Section 2, Nanchang Road, Zhongzheng District, Taipei City, Taiwan 100', UNHEX(REPLACE('1cc4f826-6ec2-5f99-b493-3941def32c70', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('阿草的店', 55, 20, 100, '免費餐點 (消費 $200)', '761ce494-a067-439f-b082-6ae296440781.jpeg', '83039f3e-79a2-4a5d-9438-dd374236a012.jpeg', '台北市中山區錦州街218號, Taipei, 104', UNHEX(REPLACE('bd9034ed-3937-5f7c-8461-c2258a14479f', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('PINEDE 彼內朵 忠孝店', 55, 25, 49, '', '203ccfd2-2afc-4bfd-96fc-d5da330bacf5.jpeg', '38a0124c-159e-4b3a-be9d-c3bfaf4e7110.jpeg', 'No. 244, Section 3, Zhongxiao E Rd, Da’an District, Taipei City, Taiwan 106', UNHEX(REPLACE('0f8041ca-9c59-5077-91f2-943ac46a269b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('KITKIT餐廳 東豐店', 50, 25, 48, '', '95dbdc46-1129-423f-b7f1-20ac09a5ec2e.jpeg', '0a1a24f6-a231-40ea-9500-f57ebda25ada.jpeg', 'Dongfeng Street 51, Da''An District, Taipei City 106', UNHEX(REPLACE('0643c8a3-1d3d-5e50-8729-a84189d6de76', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('上海鄉村', 35, 30, 100, '', '8519e9a5-db6e-463b-97bd-339d7e052968.jpeg', 'a476131c-d876-4f7b-94e3-788441d55f1d.jpeg', '100台灣台北市中正區濟南路二段37號, 台北市 100', UNHEX(REPLACE('964f5c12-1974-57ef-897d-ba9be0604870', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('蘇杭 濟南店', 30, 30, 46, '', '06344a38-fed7-4288-b824-0c9bbcda7474.jpeg', 'deda53ae-6a36-4d35-9e36-41fc8b349912.jpeg', 'Jinan Road Section 1 2-1, 1 & 2樓, Zhongzheng District, Taipei City 100', UNHEX(REPLACE('3b0b8e6d-0dbc-5894-a002-d7aef768f902', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('極 黃燜雞米飯 寧夏店', 35, 25, 48, '消費滿 $299 即可省下 $40', '43fd436c-5606-4a0c-b9db-43ecdefda91f.jpeg', 'ee355b94-4cf6-4e10-a19c-53d27baa3386.jpeg', 'Chongqing North Road Section 1 Lane 83 28, Datong District, Taipei City 103', UNHEX(REPLACE('2db03ad7-d5e2-54f0-8752-5697b849878f', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('薺元小館', 35, 30, 47, '買1送1', 'b03f2322-4998-4e85-9484-ae336e48a1bc.jpeg', '4937b488-1c74-45ba-852c-66a6bd74ac33.jpeg', 'No. 19, Section 4, Nanjing East Road, Songshan District, Taipei City, Taiwan 105', UNHEX(REPLACE('733b29d6-ef58-5144-a886-0fc1c9f9adcd', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('kiki餐廳 德惠店', 55, 30, 48, '', 'c88f9f81-cd16-4188-b75a-ef03d4ceb66f.jpeg', '525277ba-0ccd-4ef4-b24d-fd63f9e0becc.jpeg', 'Dehui Street 40, Zhongshan District, Taipei City 104', UNHEX(REPLACE('1a0f05c9-db78-5621-b939-c17287f883bb', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('開飯川食堂 忠孝店', 45, 45, 48, '', 'f7137f22-1b48-4eb9-a0e7-541c9459f6d4', 'eef06f91-9734-49b5-b65c-9b64481b775b', 'No. 98, Section 4, Zhongxiao East Road, Da’an District, Taipei City, Taiwan 106', UNHEX(REPLACE('50ffad55-2cd6-5715-97fc-67830f130b57', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('西門商圈 真川味', 45, 30, 100, '', '812f526d-2690-4fae-aeda-7acb530b4479.jpeg', 'e3683fd2-ee3d-4842-ab11-768476a51a7d.jpeg', 'Kangding Road Lane 25 42-1, Wanhua District, Taipei City 108', UNHEX(REPLACE('5b1c7a3b-22cd-5464-b5e8-f1add86442ee', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('犁園湯包館', 55, 40, 100, '', '65b88b20-8742-4599-8b4b-aa09a4a8bbde.jpeg', '705a0891-3db6-4602-a921-735e93fbccf2.jpeg', 'No. 24, Lane 256, Section 3, Nanjing East Road, Songshan District, Taipei City, Taiwan 105', UNHEX(REPLACE('61360c59-9de6-5d2d-a683-1ca6b7e7b2df', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('cama café 台北天津店', 40, 15, 49, '', '085f68b5-59c7-42fb-b76d-9ecf4c2e7246.jpeg', '5b0d7104-4b25-4223-a01a-68760f42839a.jpeg', 'Chang-An East Road Section 1 15, Zhongshan District, Taipei City 104', UNHEX(REPLACE('0a76fce2-a701-56aa-9927-9064154e64ff', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Simple Kaffa 興波咖啡', 45, 25, 100, '', '756ecc72-10bb-48a3-b914-8e28699289a2.jpeg', '1f853b78-4fd8-4a1e-ad92-3fa6bcda817f.jpeg', 'Zhongxiao East Road Section 2 27, Zhongzheng District, Taipei City 100', UNHEX(REPLACE('f7bcb807-d3fd-5f02-9b93-d64e64607190', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Louisa 路易莎 中山承德', 35, 20, 49, '', 'f61317b9-ae1a-4b09-8ed1-e3ee027dc08c.jpeg', '715b4e04-9d18-41a5-9a6c-8e155e7b3828.jpeg', '台北市大同區南京西路65號, Taipei, 103', UNHEX(REPLACE('9cfff95d-9c1e-5ad3-a2ee-bdfb4e92986b', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('STARBUCKS星巴克 南京西門市', 30, 15, 48, '', '5d07de17-c7bf-4195-bb28-9869d8d0c7d6.jpeg', '289c38f6-280f-4f43-9b31-844d60217458.jpeg', '台北市大同區南京西路 36號1f, Taipei, 103', UNHEX(REPLACE('8ab0fda0-c518-5870-af6d-b833761294a4', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('彼得好咖啡 民生雙連店', 40, 20, 49, '免費餐點 (消費 $200)', '87a8412a-ba28-41a4-984b-50df57a61574.jpeg', '45586513-9b08-4f1f-9f09-9561d059a3e2.jpeg', '台北市大同區民生西路146號, Taipei, 103', UNHEX(REPLACE('92c366e9-b6aa-5c5c-9a63-b5497e8fe0ae', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Coffee Moon 珈琲月', 50, 20, 100, '買1送1', 'faba7630-1dc2-42d6-a845-f5a58931fbdd.jpeg', '4c75d40b-ab5d-4838-becd-cf4fb321ea50.jpeg', '10491台灣台北市中山區四平街73號, 台北市 104', UNHEX(REPLACE('a1d06d69-8ff4-573b-b2b9-963f89c38a36', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Flash Coffee 行天宮門市', 50, 25, 48, '', '378b4ec8-f20d-4fe6-8c78-baa0c94def89.jpeg', 'b95b6bdd-e477-41e1-8da1-d523a52165d0.jpeg', 'Songjiang Road 223, B1, Zhongshan District, Taipei City 104', UNHEX(REPLACE('ea571045-2b9d-5700-8736-a84c80a88bac', '-', '')));
INSERT IGNORE INTO `Table_Shop` (`name`, `delivery_cost`, `shortest_delivery_time`, `score`, `discount_label`, `image_suffix`, `banner_suffix`, `address`, `uuid`) VALUES ('Woolloomooloo Simple Joy', 50, 25, 49, '', '34ce14fe-a6e1-49df-8308-d04ddc3a7371.jpeg', 'fd94ad8c-e920-44c7-ab28-2a3142873268.jpeg', 'Songjiang Road 56, Zhongshan District, Taipei City 104', UNHEX(REPLACE('6345da16-2997-5e4d-9e51-af221550908e', '-', '')));


INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('人氣精選 Popular Items', UNHEX(REPLACE('0f01af89-236d-5ec3-9ce2-d559d0b22391', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('日本風味 Japanese Ramen', UNHEX(REPLACE('f82af9a8-e54d-5c1f-bdc2-36263ce1330e', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('地獄風味 Spicy Ramen', UNHEX(REPLACE('ab030b27-44f3-5736-aff6-745dd3bf355d', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('韓式風味 Korean Ramen', UNHEX(REPLACE('f7845901-48d5-5842-85aa-6fbdca0cb27d', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('獨特風味 Special Ramen', UNHEX(REPLACE('6d1b177b-2e07-595e-a071-534b44738250', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('濃口風味 Rich Ramen', UNHEX(REPLACE('bbd7a6cd-53ea-5309-9cf7-aff9e6e45def', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('中式風味 Chinese Ramen', UNHEX(REPLACE('98f155f8-93a9-5610-b49c-18e6320e8088', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('小菜 Side Dish', UNHEX(REPLACE('dcf6ee02-e1fc-5b1b-b95e-bc96a9aad7f7', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('飲料 Beverage', UNHEX(REPLACE('799637e3-6a0a-5732-857a-e5b8bfa948ef', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('拉麵配料', UNHEX(REPLACE('c35b7fda-faa4-569a-97a0-60c1a1e099a3', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('暖心限定', UNHEX(REPLACE('a90f780a-c312-545c-92ad-267602dfa42e', '-', '')), 1);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('注意事項 Notice', UNHEX(REPLACE('84f4eb63-5f33-558f-82c3-38c097f9208a', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('人氣精選 Popular Items', UNHEX(REPLACE('00ea64e7-b5d9-516b-a6e6-efcc4691e746', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('【揪團吃超划算】第2件折50元  Group discount', UNHEX(REPLACE('1b65a7bb-e723-5a22-b5f7-6bbae5245753', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('風味獨享餐 Exclusive Meal', UNHEX(REPLACE('011950e3-c436-5823-8acf-04ebbbfe4120', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('單點主餐 Main Course', UNHEX(REPLACE('68f15c45-0fb2-55f9-aa73-9667ff5edcb3', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('單點配餐 Side Dish', UNHEX(REPLACE('ba2b54e5-19db-5d7d-a550-b600f1a86830', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('單點飲品 Beverage', UNHEX(REPLACE('6dc0171e-c7d6-58eb-97f3-5930c2cdd363', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('【逢1到21限時活動】21香草烤雞85折 ', UNHEX(REPLACE('be447216-be62-5fb7-866d-d176a53636cb', '-', '')), 2);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('🔥人氣精選🔥', UNHEX(REPLACE('a10a33cf-fc34-5610-a5ae-93930b205394', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('🌺實際消費金額滿350送免費雞塊！！🌺', UNHEX(REPLACE('a5c78e27-fcf8-5cf7-835c-4a3c7c619da2', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('❤️我們會越來越好❤️', UNHEX(REPLACE('7e7bf229-1271-5d57-93b0-d11ad4b96fdb', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('🤜🏼抗疫應援特別套餐組合🤛🏼', UNHEX(REPLACE('d4a71c53-b98c-541e-9027-ac5281f85030', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('🎃兔寶寶吃好料🎃', UNHEX(REPLACE('f2118a91-506b-5df3-b412-0952b3ed9497', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('👻兔寶寶大總匯👻', UNHEX(REPLACE('0802dd3b-3e23-54c4-bf85-60bf0b974672', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('👹兔寶寶吃蛋餅👹', UNHEX(REPLACE('b716d2a5-f545-51ad-9c6a-121dedb7c336', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('👑兔寶寶最愛蔥抓餅👑', UNHEX(REPLACE('6f5b3960-3e61-5270-923d-d71955f210c6', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('🍄兔寶寶單點兒🍄', UNHEX(REPLACE('9eaec663-e788-5c68-a52e-0c86be5d9be6', '-', '')), 3);
INSERT IGNORE INTO `Table_Good_Channel` (`title`, `uuid`, `shop_id`) VALUES ('🥤兔寶寶喝飲料🥤', UNHEX(REPLACE('b5265878-c67b-5727-ad45-6849b7496021', '-', '')), 3);


INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('東京豚骨拉麵 Tokyo Tonkotsu Ramen', 129, '大骨湯，甘醇醬油獨特風味。', 'd4bd1dcf-0a40-4865-9a52-667440b9b5d1.jpeg', '', 1, 1, 1, 1, UNHEX(REPLACE('b7b351dc-8bc3-58d2-9088-79080768e825', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('九州白湯拉麵 Kyushu Broth Ramen', 129, '大骨湯，牛奶海鹽濃郁口感，較清淡', 'b83761f2-98bc-43a9-9ba6-ed70230e10f1.jpeg', '', 0, 0, 1, 1, UNHEX(REPLACE('1768f9ea-009d-512b-b191-2fecbd4be249', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('釜山紅湯拉麵 Busan Red Soup Ramen', 139, '特製蝦醬，蒜。熬製而成海鮮風味', '35453010-3484-41dd-9e17-7d92d15ae345.jpeg', '', 0, 0, 1, 1, UNHEX(REPLACE('4caa4d4b-bd79-513d-b878-8d739414f334', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('四川麻辣豚骨拉麵 Sichuan Hot and Spicy Tonkotsu Ramen', 218, '', '542819fa-9321-4171-b3db-bc56d794d42d.jpeg', '小辣 Mild', 0, 0, 1, 1, UNHEX(REPLACE('5d2f060d-c57e-5a4f-9c14-bfc31e1a1378', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('東京煉獄拉麵 Tokyo Spicy Ramen', 139, '豚骨湯底，特製地獄醬，含牛油成分。', 'ef44e956-93db-4f92-b9a7-a37923a084e0.jpeg', '小辣 Mild', 0, 0, 1, 1, UNHEX(REPLACE('fb5235a4-cb08-53de-ac54-f8bb92866964', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('黑蒜豚骨拉麵 Tonkotsu Ramen with Black Garlic', 149, '', 'e67e8dd8-33d7-48de-a100-f5ec71c07ccf.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('79acc632-4584-5ee1-a20a-1658366ed90c', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('濃口豚骨拉麵 Rich Tonkotsu Ramen', 149, '', 'e717b4b6-24e7-47b8-9720-6dcbbc1a5301.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('072f62ff-925a-5757-ab95-d8c0de9ee618', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('東京醬油拉麵 Tokyo Soy Sauce Ramen', 129, '日式醬油，柴魚的香氣，較清淡', '35fb711b-b3f6-439d-8bed-cf28b712fe18.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('dffcb09d-972c-5b92-bcdf-939ee9d8aade', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('札幌味噌拉麵 Sapporo Miso Ramen', 129, '紅味增，白味增。特調味增口感', '60a3a1fe-d1fe-4ba8-87c4-51b198ae4c4b.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('6347d5d9-4b0d-5534-b9e8-0f8af2512d85', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('九州地獄拉麵 Kyushu Spicy Ramen', 139, '白湯湯底，特製地獄醬，含牛油成分。', 'e5e9095f-e3c0-4ece-b659-74c24736e279.jpeg', '小辣 Mild', 0, 0, 0, 1, UNHEX(REPLACE('9ad746fc-e77f-534e-8edd-6713e27d6636', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('札幌魔獄拉麵 Sapporo Spicy Ramen', 139, '味增湯底，特制地獄醬，含牛油成分。', '2accb114-67ca-4052-b12d-29d315f8adc9.jpeg', '小辣 Mild', 0, 0, 0, 1, UNHEX(REPLACE('e062e8f8-0038-532c-84a9-a2e59f2727cb', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('韓式泡菜拉麵 Korean Kimchi Ramen', 139, '大骨湯，微辣調製泡菜口味', 'e9ad2908-ad3e-4acd-9fab-b572b25499ce.jpeg', '小辣 Mild', 0, 0, 0, 1, UNHEX(REPLACE('4699fc6c-0556-5b80-9a5f-4661bcab170d', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泰式豚骨拉麵 Thai Tonkotsu Ramen', 149, '', 'a21cb620-b3f3-49cb-974c-92e41b1808ef.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('bbd0d792-924d-5479-8653-8a19ce5fa72b', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('濃口白湯拉麵 Rich Broth Ramen', 149, '', '83375c9a-aa35-4b4b-86c6-762964512cda.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('64d2612f-9ee0-5da2-aa13-a5026f42366b', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('蒙古白湯拉麵 Mongolian Broth Ramen', 139, '濃郁孜然香氣添加枸杞的獨特風味', '5ed92310-d099-4101-8d98-d63e4d93658c.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('2a3dda54-03e7-59ef-805c-ff57bd418b02', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('糖心蛋 Coddled Egg', 25, '', '3d3db710-279c-40b7-b551-0b5f46c2753b.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('6b5ff008-e18c-503c-b285-1b71def49faf', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('叉燒肉 Basted Meat', 35, '一份兩片', 'ac8cc2ef-d682-45bf-9915-bdb2904d90ef.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('6bb63d2f-60d0-5b60-878a-675bbb1b4671', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('海帶豆干 Kelp and Tofu Curd', 45, '', '560eedce-b619-4ce5-a39e-e56f8f513643.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('53d1f145-5464-57ba-bc70-4253d366e717', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('麻油粉肝 Pork Liver with Sesame Oil', 45, '', 'e43ff25a-0096-46a4-b47e-7903efbdec8c.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('08308239-2982-5008-b5d7-0539e47e7c8b', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鳳爪 Chicken Feet', 45, '', '8085ca53-9880-442e-a901-b244bb602902.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('6e534028-1bdb-573e-bee7-3bcd39f9e38e', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('皮蛋豆腐 Century Egg with Tofu', 45, '', 'cc79ea7f-a6da-48ee-acaa-2ec1a69944f7.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('9ceb51e3-3ac9-5a34-ad08-ffbc8e488d4c', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('韓式泡菜 Pickled vegetable', 69, '', '4cc4d32e-c20a-41f2-b241-5cb5aaa2429b.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('945a3d7c-73fe-5c54-8d98-0cf354fe735c', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('脆筍 Crisp bamboo shoots', 69, '', '67b3efd2-8841-459e-aece-e32df09984e6.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('fb54b898-1fe5-5539-bb9b-920961d5f9fa', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('可口可樂 Coke', 22, '', '8e09f468-ee2b-431f-92b6-5338cbfa29b9.jpeg', '', 1, 0, 0, 1, UNHEX(REPLACE('babe7df2-3e93-51a0-801e-499d222d4ea2', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('雪碧 Sprite', 22, '', '3f82a95b-31f3-41a4-ba06-83667f9716d3.jpeg', '', 1, 0, 0, 1, UNHEX(REPLACE('5386d489-1775-52c3-9ff2-ba82e5aaa788', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('原萃日式無糖綠茶', 30, '580毫升', '', '', 1, 0, 0, 1, UNHEX(REPLACE('ed113f82-2f65-5faa-b06b-27052bb9a95f', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('玉米粒', 25, '', '4c92bb93-5593-4b68-bce7-b998dffdc54c.jpeg', '', 1, 0, 0, 1, UNHEX(REPLACE('b66db7f3-dbbe-502c-9a50-ece4aec6dd11', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('糖心蛋半顆+叉燒肉一片', 30, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('55ff606a-55e5-5f50-a3b5-ad7a6f36845c', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('養身天然膠原桂花凍', 90, '用桃膠、素雪燕、雪蓮子、百合、白木耳製成 再以紅棗、枸杞、龍眼、桂花釀調味 食用方式： 冷-凍狀直接食用 熱-倒入瓷碗微波加熱後食用', '149fd293-05d3-4a7e-af78-d57e61c802d7.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('680dd8bb-d8b7-51e8-aee0-5fa9368fe8c7', '-', '')), 1);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('21香草烤雞腿-無沾醬', 89, '21 Roast Chicken Drumstick(No sauce) 無附烤雞沾醬，需另外選購。歡慶2021來21全年香草烤雞腿21%off優惠(原價100元)。嚴選100%國產鮮雞, 獨有研發21種天然香料滾打入味, 以獨家蒸烤技術製作出鮮嫩多汁的21香草烤雞腿。', '315d5eec-6d70-46e4-98ac-70086037022d.jpeg', '', 1, 1, 1, 1, UNHEX(REPLACE('4f759986-ad6d-59ce-b2db-219292b7a90e', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('雞汁溫蔬菜', 85, 'Warm vegetable 嚴選季節時蔬加入鹹香雞汁, 健康均衡口味清爽, 提供您無負擔的美味。', 'c76204cc-27ab-415f-9985-da8d374e3dd1.jpeg', '', 0, 0, 1, 1, UNHEX(REPLACE('2d7bb508-3029-5337-a456-e4921fb62f21', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香脆炸雞(微辣)', 55, 'Fried Chicken (Slightly spicy) 炸雞提供雞腿部位(棒棒腿及腿排), 新鮮嫩雞腿肉, 加上獨家香料滾打入味, 以芥花油酥炸出多汁口感。', 'b5a73f28-736c-4e92-a948-14690fd42990.jpeg', '微辣 slightly spicy', 0, 0, 1, 1, UNHEX(REPLACE('f2952c2c-d741-51e6-90a8-abff0e7a181f', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('【逢1到21】21香草烤雞-85折', 440, '21 Whole Roast Chicken 附2個烤雞沾醬。嚴選100%國產鮮雞, 獨有研發21種天然香料滾打入味, 以獨家蒸烤技術製作出鮮嫩多汁的21香草烤雞。', '36bb2607-010b-4fce-9b08-ea8f5a088603.jpeg', '', 1, 0, 1, 1, UNHEX(REPLACE('f6de8453-b01b-5513-a551-528508d2a94c', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('大薯霸', 65, 'French Fries 嚴選美國AA最高等級馬鈴薯, 外酥內軟, 是本店的超人氣商品。', '205c97f1-d2d3-4566-993e-f886a19139c6.jpeg', '', 0, 0, 1, 1, UNHEX(REPLACE('463c2785-336d-520f-92dd-57fad3e7092b', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('注意事項(勿下單) Notice', 0, '1.因應政府政策不提供吸管，敬請見諒。
2. 逢1到21每月1、11、21、31日單點香草烤雞(附2醬)享85折優惠。優惠不重複，如當日遇其他優惠活動，則取消逢1到21優惠活動。
3.餐點不主動提供胡椒鹽、番茄醬，如有需要請於備註欄說明份數，環保愛地球請適量索取，避免食材浪費，每份餐點(飲料除外)備註最多提供各2包。
4.香脆炸雞全面升級為雞腿部位，雞腿含腿排及棒棒腿，恕無法挑選部位。香脆炸雞微辣，如完全無法吃辣朋友請斟酌選購
5. 全台各門市販售商品項目略有不同，請以各店網頁販售為主。
6. 圖片僅供參考，依實際門市提供餐點為主。
7. 如對訂單有任何疑問，請透過APP聯繫Uber Eats優食外送客服團隊.
21Plus、21風味館謝謝您的購買', '', '', 1, 0, 0, 1, UNHEX(REPLACE('12af6f19-c263-5604-86ec-25172aaf8ec8', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('塑膠袋 Plastic Bag', 3, '為響應環保恕無提供免費塑膠袋，若您訂餐金額超過1000元建議點此購買塑膠袋。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('3b62f4b4-be70-5d15-bcd0-1c4da955cc16', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香脆炸雞腿堡餐(微辣)', 167, '套餐附大杯飲料。香脆炸雞腿堡x1、小薯霸x1。使用義大利帕米桑乳酪絲製成的圓麵包，起司香氣十足與膨鬆口感提升漢堡的堡體豐富層次，將厚實雞腿排手工裹粉炸成金黃帶有鱗片的經典辣味腿排，搭配新鮮爽脆生菜一同大口咬下，勁脆厚實的炸雞腿堡，21強厚推出。', '58ba15b9-9d9e-4e79-bd4f-dd2a4bad952e.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('deabbd17-2889-52a2-92e3-965fde99effb', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香草烤腿起司堡餐', 167, '套餐附大杯飲料。香草烤雞腿起司堡x1、小薯霸x1。香草烤腿起司堡使用義大利帕米桑乳酪絲製成的圓麵包，搭配21招牌醃製去骨雞腿排淋上滿滿特調美式炭烤醬及鮮脆生菜，最後放上口感厚實切達起司片，將微融的切達起司與美式炭烤醬一同咬下，濃濃的異國美式風味烤雞腿起司堡，21醬濃推出。', 'a7ad0b34-89c7-46ec-8fff-3ccf1a86fedd.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('a373083c-0c0c-5b33-9b8e-a90989848f43', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('外送-香脆炸雞風味餐', 177, 'Crispy Deep-Fried Chicken Meal 指定附冬瓜檸檬凍飲。含2個香脆炸雞, 小薯霸。炸雞升級只有雞腿及腿排。Big份量爽脆過癮，給喜愛炸雞的朋友最佳首選。(國產雞肉，炸雞僅提供雞腿部位，微辣，雞腿含腿排及棒棒腿，恕無法挑選)', 'a34a06ef-7c20-4793-94cc-af84831249aa.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('aca4e6b1-eb0f-5963-947c-aca34d416f2b', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香草烤雞腿飯風味餐', 182, 'Roast Chicken Drumstick Rice Meal 套餐附香草烤雞蓉玉米濃湯(小)x1。21香草烤雞腿+白飯+季節配菜，滿分飽足感超高人氣餐盒No.1。【湯品不得更換】(國產雞肉)', '1e44e8d8-0012-48b3-afed-a16fb237e34c.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('53094595-46f6-504d-bceb-3a1df1f8c966', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('21香草烤半雞風味餐', 287, '21 Half Roast Chicken 套餐附大杯飲料x1。香草烤半雞x1、Gravy烤雞沾醬x1、大薯霸x1。招牌香嫩烤雞搭配酥脆薯條，1人獨享分量剛剛好。(國產雞肉)', '2f98e405-df8c-4dd3-a0b3-64b7134f79e2.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('6f8daa22-a6a0-5057-9b5c-fded04cebe1a', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('《UberEats限定》烤半雞獨享餐x2 #8143', 510, '單份套餐內容：香草烤半雞x1、大薯霸x1、烤雞沾醬x1、大杯飲料x1 招牌香草烤半雞鮮嫩多汁，使用21種天然香料調味，獨特蒸烤箱技術將肉汁鎖入在內，充滿水份的鮮嫩烤雞肉成為經典招牌，附烤雞沾醬，一次可以吃到2種風味的烤雞絕對是必點餐。第2件省50元。', '7919ee0e-bffe-4bb9-a91e-6f05c8139e10.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('92080841-8681-5506-bbc5-995a6ac367d7', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('《UberEats限定》烤炸炸獨享餐x2 #8144', 380, '單份套餐內容：香草烤雞腿x1、香脆炸雞x2、大杯飲料x1 炸雞烤雞通通滿足到，喜愛同時吃到不同風味的你最適合的套餐。第2件省50元。(香脆炸雞使用雞腿部位，有腿排及棒腿，無法提供挑選，微辣)', '0a41c07f-6d82-4938-80a4-cfd624964d6d.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('70a52b9e-f147-5100-8ecb-b4e95aaaaea7', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('《UberEats限定》香草烤雞腿獨享餐x2 #8145', 280, '單份套餐內容：香草烤雞腿x1、大薯霸x1、大杯飲料x1 肉質鮮嫩的香草烤雞腿，搭配大薯霸，招牌超人氣套餐。第2件省50元。', '95c75c75-c99a-4ac4-a131-111570ac4fa4.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('503a9718-759c-535d-88d0-312e7fc9e8c3', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('《UberEats限定》烤雞腿飯獨享餐x2 #8146', 300, '單份套餐內容：香草烤雞腿飯x1、冬瓜檸檬凍飲x1 超有飽足感的雞腿飯，將招牌21香草烤雞腿占滿餐盒加上季節蔬菜與粒粒飽滿的白米飯，份量十足，搭配濃濃復古味冬瓜檸檬凍飲，酸甜滋味超解膩，搭配餐點最對味。第2件省50元。(飲料不得更換)', '0a4de3e8-4c1e-4414-8705-045270476965.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('d5607478-a622-5a11-822f-4018e0227028', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香草烤腿起司堡餐', 167, '套餐附大杯飲料。香草烤雞腿起司堡x1、小薯霸x1。香草烤腿起司堡使用義大利帕米桑乳酪絲製成的圓麵包，搭配21招牌醃製去骨雞腿排淋上滿滿特調美式炭烤醬及鮮脆生菜，最後放上口感厚實切達起司片，將微融的切達起司與美式炭烤醬一同咬下，濃濃的異國美式風味烤雞腿起司堡，21醬濃推出。', 'a7ad0b34-89c7-46ec-8fff-3ccf1a86fedd.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('d320d3cd-268a-5a9b-b633-29c19286a454', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香脆炸雞腿堡餐(微辣)', 167, '套餐附大杯飲料。香脆炸雞腿堡x1、小薯霸x1。使用義大利帕米桑乳酪絲製成的圓麵包，起司香氣十足與膨鬆口感提升漢堡的堡體豐富層次，將厚實雞腿排手工裹粉炸成金黃帶有鱗片的經典辣味腿排，搭配新鮮爽脆生菜一同大口咬下，勁脆厚實的炸雞腿堡，21強厚推出。', '58ba15b9-9d9e-4e79-bd4f-dd2a4bad952e.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('53fd5ccd-0586-516b-8836-65d908e3b1c4', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香草烤雞腿濃起司披薩餐', 207, '套餐附大杯飲料。香草烤雞腿起司披薩(6吋)、香脆炸雞翅(微辣)。適合一人獨享的披薩，以主廚調配西西里番茄醬為基底，撒上鮮甜爽口的洋蔥丁、青花丁、招牌香草烤雞肉絲及紮實雞腿肉，豪氣灑上滿滿起司絲，將表皮烤製金黃焦香，最後撒入帕瑪森起司粉為披薩更增添濃郁起司香氣，濃心上市。', 'dc69db3d-ef94-4f4c-8120-0119273dfbda.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('75404731-b313-5453-a0de-f3149b156f58', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('外送-香脆炸雞風味餐', 177, 'Crispy Deep-Fried Chicken Meal 指定附冬瓜檸檬凍飲。含2個香脆炸雞, 小薯霸。炸雞升級只有雞腿及腿排。Big份量爽脆過癮，給喜愛炸雞的朋友最佳首選。(國產雞肉，炸雞僅提供雞腿部位，微辣，雞腿含腿排及棒棒腿，恕無法挑選)', 'a34a06ef-7c20-4793-94cc-af84831249aa.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('7b824671-6bcb-50dc-865c-6d67563ba4f6', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('炸烤雙霸風味餐', 222, '21Roast Chicken Drumstick & Fried Chicken 套餐附大杯飲料x1。21香草烤雞腿x1、香脆炸雞x1、椒麻薯霸x1。烤炸雙主菜大口吃肉超過癮，附上椒麻粉，有著藤椒的麻感與辣椒粉的辣感，麻辣交織配上鮮甜馬鈴薯薯條，涮嘴的滋味令人無法抗拒，可依照個人口味加入椒麻調味粉，在袋內充分搖均勻後即可享用，霸氣套餐超滿足。〔香脆炸雞微辣〕', '8e15dd1c-1cef-4eaa-816a-08cd03c0dc12.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('aa48b3ff-e969-505f-8612-5cc80296eba4', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香草烤雞腿飯風味餐', 182, 'Roast Chicken Drumstick Rice Meal 套餐附香草烤雞蓉玉米濃湯(小)x1。21香草烤雞腿+白飯+季節配菜，滿分飽足感超高人氣餐盒No.1。【湯品不得更換】(國產雞肉)', '1e44e8d8-0012-48b3-afed-a16fb237e34c.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('4731f04f-8b13-5077-8dc8-1d51ec2af341', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('21香草烤半雞風味餐', 287, '21 Half Roast Chicken 套餐附大杯飲料x1。香草烤半雞x1、Gravy烤雞沾醬x1、大薯霸x1。招牌香嫩烤雞搭配酥脆薯條，1人獨享分量剛剛好。(國產雞肉)', '2f98e405-df8c-4dd3-a0b3-64b7134f79e2.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('9adcdcab-937d-5c02-8469-dfa382c3dbee', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('21香草烤雞腿風味餐', 172, '21 Roast Chicken Drumstick Meal 套餐附大杯飲料x1。21香草烤雞腿x1、薯霸x1。招牌組合人氣個人餐No.1。(無飯)(國產雞肉)', 'b92d4369-1e2c-4286-b18c-ff2b9cd7f702.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('b6981888-3206-59ba-baf7-2c97b532f7e8', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鮮蔬手撕雞風味餐', 172, 'Taiwanese salty chicken 套餐附大杯飲料。7種鮮蔬與手撕烤雞肉, 拌入21特調雞汁精華, 溫熱清爽口感, 一份只有334卡路里,輕食選營養滿分健康零負擔。(國產雞肉)', '6af7a897-4b87-48bf-9dc7-068d402cdc7d.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('afbee8e5-74ba-5028-aac5-9a522fca0f2c', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('UberEars限定》三炸風味獨享餐', 190, '3 pieces crispy fried chicken set 套餐附大杯飲料x1及香脆炸雞x3。使用國產鮮嫩雞腿肉，手工裹粉新鮮現炸，金黃色酥脆外皮包覆著鮮嫩多汁雞腿肉，一次享有三塊炸雞的飽足美味，熱愛炸雞的你必點。(國產雞肉，炸雞僅提供雞腿部位，微辣，雞腿含腿排及棒棒腿，恕無法挑選)', 'a1738586-f031-483d-9e0e-c808ab4c0e53.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('35687772-b7fe-5df7-b354-8c95bdaeef8b', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('《UberEats限定》烤炸炸風味獨享餐', 215, 'Roasted Chicken Drumsticks and Double Fried Chicken Set 套餐附大杯飲料x1。21招牌香草烤雞腿x1及香脆炸雞x2，可以同時吃到烤雞炸雞的美味又能大啖鮮嫩雞腿肉的滿足，喜愛大口吃肉也能享受烤炸雙滿足的豐盛套餐。(國產雞肉，炸雞僅提供雞腿部位，微辣，雞腿含腿排及棒棒腿，恕無法挑選)', '5b18d446-ea67-4de6-9550-b234151a9fc6.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('9f5c175f-9a03-52c6-b977-df850178acb1', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('21香草烤雞', 440, '21 Whole Roast Chicken 附烤雞沾醬x2。嚴選100%國產鮮雞, 獨有研發21種天然香料滾打入味, 以獨家蒸烤技術製作出鮮嫩多汁的21香草烤雞。', '81648e44-ec82-4957-a28b-431ecc9b6fc9.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('97d3a981-c6d7-5789-8b51-e23ea77cc737', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('21香草烤半雞', 225, '21 Half Roast Chicken (15%off) 附烤雞沾醬x1。嚴選100%國產鮮雞, 獨有研發21種天然香料滾打入味, 以獨家蒸烤技術製作出鮮嫩多汁的21香草烤半雞。', 'd522f97d-c307-4a36-a81f-0285331b81f9.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('8149fc01-c48f-53af-9983-b9e2433b9733', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('21香草烤雞腿-附沾醬', 130, '21 Roast Chicken Drumstick(With sauce) 附烤雞沾醬x1。嚴選100%國產鮮雞, 獨有研發21種天然香料滾打入味, 以獨家蒸烤技術製作出鮮嫩多汁的21香草烤雞腿。', '461c9007-f881-401a-9e5c-67de3b0274ed.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('cc4cf518-cdff-53d0-9361-647ef1a10643', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('焗烤起司雞', 350, '使用招牌21香草烤半雞，以獨特香濃起司醬裹覆鮮嫩烤半雞，並鋪上奶香充裕的起司條烤製金黃微焦色澤。一盤濃濃起司，香而不膩，令人幸福的滋味滿足味蕾的享受', '28a1a7d8-6403-4ef4-be7b-16be85fa01ba.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('483ef294-2413-51c7-8d9f-65d19bf759e3', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香脆炸雞腿堡(微辣)', 110, '使用義大利帕米桑乳酪絲製成的圓麵包，起司香氣十足與膨鬆口感提升漢堡的堡體豐富層次，將厚實雞腿排手工裹粉炸成金黃帶有鱗片的經典辣味腿排，搭配新鮮爽脆生菜一同大口咬下，勁脆厚實的炸雞腿堡，21強厚推出。', '89daacd1-fd1a-4257-b88a-c928066cb833.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('154b77c4-59f4-528a-87bd-dfdc78f40699', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香草烤腿起司堡', 110, '使用義大利帕米桑乳酪絲製成的圓麵包，搭配21招牌醃製去骨雞腿排淋上滿滿特調美式炭烤醬及鮮脆生菜，最後放上口感厚實切達起司片，將微融的切達起司與美式炭烤醬一同咬下，濃濃的異國美式風味烤雞腿起司堡，21醬濃推出。', 'c49d012d-258c-4ea3-823e-eed10f1bfb4a.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('ace793a9-ec6c-524b-857f-002607858015', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('西西里雞肉起司披薩 (8吋)', 175, '8 Inch Sicily Chicken Pizza 將招牌烤雞手工撕成雞絲，以主廚調配西西里番茄醬為基底，撒上鮮甜洋蔥丁、烤雞絲，最後鋪上滿滿起司條與香濃起司粉。每片披薩都能拉出濃郁起司絲，視覺的美食享受與味覺的美味享受同時滿足。適合2人分享的雞肉起司披薩大小朋友都愛。', '5447b744-266e-4da1-9eb5-4b207e2e147e.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('0216a89d-2d98-5e8f-b68f-9356c217a73d', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香草烤雞腿濃起司披薩(6吋)', 160, '以主廚調配西西里番茄醬為基底，撒上鮮甜爽口的洋蔥丁、青花丁、招牌香草烤雞肉絲及紮實雞腿肉，豪氣灑上滿滿起司絲，將表皮烤製金黃焦香，最後撒入帕瑪森起司粉為披薩更增添濃郁起司香氣。適合1人獨享的超濃烤雞腿起司披薩，濃心上市。', '54ba8ec8-fa8d-4ae4-ad3d-339c1793ea14.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('22383dd7-c1fb-5abe-925c-1139ad4311a8', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泰式炸雞桶 (5入)', 259, 'Thai Style Fried Chicken 5pcs 整桶都是雞腿部位，吃炸雞不用再搶雞腿，鮮嫩肉質豐富的雞腿肉，手工裹粉新鮮現炸，鱗片狀的金黃色皮衣口感香酥脆，雞汁鎖入皮衣內，一口咬下雞汁噴發，美味程度直接破表，搭配特調的泰式酸辣醬，原味吃、沾醬吃都有不同風味。(腿部包含腿排及棒棒腿，恕不能挑選，香脆炸雞微辣)(附泰式酸辣醬)。', 'f3549a43-9081-4312-ad98-be1304594fd0.jpeg', '微辣 slightly spicy', 0, 0, 0, 1, UNHEX(REPLACE('d3da26bb-e439-59b9-9fbf-7b42ae48c3f0', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('翅炸雙拼(微辣)', 235, '餐點包含：香脆炸雞x3、香脆炸雞翅x2。香脆炸雞翅選用三節翅，肉質最鮮嫩，三節翅份量充足，搭配香脆炸雞，想吃雞翅雞腿通通都在這一盒，CP值超高的美味炸雞。', '581c87d0-668b-499c-a497-0b2969fe760b.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('4eedfafd-f4b4-5245-986b-3b676e35aec0', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香脆炸雞(微辣)', 55, 'Fried Chicken (Slightly spicy) 炸雞提供雞腿部位(棒棒腿及腿排), 新鮮嫩雞腿肉, 加上獨家香料滾打入味, 以芥花油酥炸出多汁口感。', 'b5a73f28-736c-4e92-a948-14690fd42990.jpeg', '微辣 slightly spicy', 0, 0, 0, 1, UNHEX(REPLACE('e84aa743-0d95-5580-9ccd-9e6d33398de8', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鹹蛋黃薯霸', 75, 'Salted Egg Fries 嚴選美國AA最高等級馬鈴薯, 外酥內軟, 搭配鹹蛋黃調味粉，可依照個人口味喜好加入袋內充分搖均勻後，薯條充滿著濃郁鹹蛋黃味，鹹香口感讓人一口接一口停不下來。', '37cbc44d-af64-4e06-a042-03d4fb365148.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('b4fd267b-b84a-5822-9d5a-a36382bebb8f', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('紫玉地瓜球', 50, 'Sweet Potato balls 紫地瓜與黃地瓜製作出綿密雙色地瓜球，香酥外層、口感Q軟的國民美食，飯後甜點、下午茶零嘴都適合。', 'acda69e2-48ac-43e9-9e5b-af6f9601ba7f.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('79e55e2e-0089-529c-9e40-1d8f362cb924', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('白飯', 20, 'Rice 使用優質純正100%台灣國產米, 擁有農糧署認證台灣米標章, 品質有保障。配烤雞炸雞, 沾醬最下飯。', 'ef3e667d-435a-4cfb-8dcf-64bf839e2f30.jpeg', '', 1, 0, 0, 1, UNHEX(REPLACE('a016e19d-62ee-5f82-a0e0-88dd389650e7', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('Gravy雞汁辣醬', 30, 'Gravy Spicy Chicken Sauce 21主廚研發調製，與烤雞搭配風味更佳，沾醬類銷售NO.1', '', '小辣 Mild', 1, 0, 0, 1, UNHEX(REPLACE('3ba218e0-780f-5e0b-98d0-a6796c437704', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('美式炭烤醬', 30, '特調美式煙燻炭烤風味，加入多種異國香料，充滿多重香氣的烤雞沾醬，搭配烤雞、炸雞或薯條都是非常適合。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('95c05b77-407c-5ad1-b16e-ce5ad9bfacd8', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泰式酸辣醬', 30, 'Thai Sour and Spicy Sauce 微辣中帶酸甜, 開胃又爽口, 適合搭配炸雞等炸物類。', '', '微辣 Less Spicy', 1, 0, 0, 1, UNHEX(REPLACE('026d38e5-bc35-5466-b5f1-23431914e9b7', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('冬瓜檸檬凍飲', 55, 'Iced White Gourd Drink with Lemon 好評回歸，復刻台味。古早味冬瓜茶加入100%檸檬汁果凍，酸酸甜甜的滋味超開胃。', 'e8398657-de8a-4dfd-80df-97c568188691.jpeg', '', 1, 0, 0, 1, UNHEX(REPLACE('56283ab1-a361-554f-8cd3-d77dc38e021a', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('西柚優格氣泡飲', 55, '期間限定，100%原汁葡萄柚加入酸甜優格，並以沁涼氣泡水調和，呈現日落金橘色澤，搭配美食共享超解膩，單獨暢飲更是夏天消暑聖品。(甜度、冰塊無法調整)', '09fff861-4d69-4c46-aa2c-41b411bd6c27.jpeg', '', 1, 0, 0, 1, UNHEX(REPLACE('514d1692-0574-561f-ae05-e0dc7b213ad8', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('蜂蜜綠茶', 35, 'Honey Green Tea 大杯。21經典飲品, 蜂蜜與綠茶的完美調和。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('4c01c0e2-5784-5bcb-a52e-ffde591480cb', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('四季春冰茶 (無糖)', 35, 'Iced Sihji Oolong Tea 21經典飲品, 四季春茶無糖的清爽', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c481188e-20c3-5f73-8da9-06ca476bfe4a', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('逢1到21活動注意事項', 0, '1、每月1、11、21、31日單點香草烤雞、85折優惠。 2、優惠活動不重複，如當日有其他優惠活動，則逢1到21取消乙次。 3、點選本類別餐點才享折扣，其他類別同餐點恕不享折扣。 4、12/31逢1到21活動暫停乙次。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('68df8b3d-0645-5afe-8f3d-6c964dc8b6ff', '-', '')), 2);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('檸檬雞柳條', 10, '一份1條。
*若是滿額贈送的雞柳條「不需要」「不需要」「不需要」加購物車，我們會直接附上！
如果不用雞柳條的話再幫我們附註下，感謝🙏', '', '', 1, 1, 0, 1, UNHEX(REPLACE('a637b28b-1e6b-5019-82cb-5e09727e5ab2', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('起司辣肉醬麵肉蛋雙拼套餐🔥🔥🔥', 160, '附薯餅及大杯飲料。', '63700de0-3211-47d9-bdfc-7ad19b43057d.jpeg', '小辣', 1, 0, 1, 1, UNHEX(REPLACE('6f08cad5-764c-53d0-889a-9c7c8cc70933', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鮪魚玉米蛋餅👍🏼', 60, '', '', '', 1, 0, 1, 1, UNHEX(REPLACE('3dc868e7-71a5-5906-a41e-76b651109f01', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('蘿蔔糕炒蛋👍🏼', 55, '', '', '', 1, 0, 1, 1, UNHEX(REPLACE('e4a2f685-ec8c-5b1f-8be6-9639ca652d96', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('起司蛋抓餅', 55, '', '', '', 1, 0, 1, 1, UNHEX(REPLACE('4d9fa7ba-398f-57ea-adf1-c65ff85494b4', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('煎餃加蛋/煎餃炒蛋', 65, '一份10顆。
煩請備註要荷包蛋還是煎餃炒蛋，若無備註會直接做荷包蛋，謝謝。', '', '', 1, 0, 1, 1, UNHEX(REPLACE('f55f77e1-8755-5dde-911d-7bcc436bd324', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('炸物拼盤套餐', 145, '', 'f666ea82-3d28-4da1-94fe-4c7188cf211f.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('0685fe40-1114-5997-bdb3-af5d3d378207', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('辣培根薯泥起司蛋堡套餐🔥', 150, '', '5b763cf1-14e0-4880-82d9-1ece5449e849.jpeg', '小辣', 0, 0, 0, 1, UNHEX(REPLACE('e2f266d9-240b-55eb-b8a7-0e514fa8e2b5', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('花醬美式總匯套餐', 150, '', 'e0a41c40-f77b-4af3-95fc-4ac5ae4a0b6c.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('21741b9c-a3f7-5492-ac55-d7605cc8a5f6', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('塔香豬排起司蛋抓餅套餐', 155, '', 'bb72bd68-e7ad-444a-8c22-8a14dc4c378e.jpeg', '', 0, 0, 0, 1, UNHEX(REPLACE('8349af11-7d6d-58ee-96f1-0b2d7e2606a8', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('起司辣肉醬麵肉蛋雙拼套餐🔥🔥🔥', 160, '', '63700de0-3211-47d9-bdfc-7ad19b43057d.jpeg', '小辣', 0, 0, 0, 1, UNHEX(REPLACE('1c004c08-b54b-5be3-b563-8933be891e92', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('消費滿350元的免費雞塊！！', 0, '消費滿350元送免費雞塊記得勾選～
一份4個。
一單兌換一次。
以實際金額計算，不含運費喔！謝謝你們～', '', '', 1, 0, 0, 1, UNHEX(REPLACE('38e2deeb-1ada-54cb-b4b8-9a6875b6a714', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('✅  謝謝大家在這麼多好吃的東西中選擇了兔寶寶漢堡店！', 0, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('b643d9f0-cdd2-5e80-b1de-78bd7a06a560', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('✅  希望我們用心製作的餐點能讓您吃得開心吃得滿意☺️', 0, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('88bae582-00f2-5aeb-9a0a-30e5d0243785', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('✅  想拜託大家餐後幫我們在平台上留個五星好評，因為系統會每天清除之前的評價，需要您的幫忙，讓我們不會被洗到很後面，感謝您喔！', 0, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('b60f45c4-aafc-53f0-9247-020b09b2a501', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('有菜有肉有蛋營養套餐', 150, '元氣滿載的蔬菜起司蛋餅+一片蘿蔔糕+荷包蛋+黑胡椒豬排片+大杯飲料。
*套餐內容恕無法更換。需要加辣請備註，會幫您放角落辣椒無法另外包，謝謝！', '', '', 1, 0, 0, 1, UNHEX(REPLACE('7dfc9486-df6d-5cbb-ad33-99d5b100777a', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('抗疫殺菌到底套餐', 160, '洋蔥起司蛋抓餅+蒜香辣燻雞吐司+大杯飲料。
在家爽吃不怕臭臭！
*吐司可不辣，抓餅要辣請備註，辣椒無法另外包，謝謝。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('408fb6e2-e4e3-5730-b06c-8ee10a0f3b3a', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('好想出國玩耍套餐', 180, '泰甜辣蝦排蛋堡(炸蝦排、蛋、洋蔥、高麗菜絲、泰式甜辣醬)+韓式泡菜豬排蛋餅+大杯飲料。
*蛋餅加辣請備註，會幫您放盒子角落，辣椒無法另外包，謝謝。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('137d4053-750f-532b-858e-594a8616cee2', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('肥宅快樂吃套餐', 220, '香脆咔薯蛋堡(咔拉雞腿排、薯餅、蛋、洋蔥、高麗菜絲)+綜合炸炸(雞米花一份、脆薯一份、熱狗2隻)+大杯飲料。
*套餐內容恕無法更換！
*若雞米花售完會換成雞塊，謝謝。
咔拉雞腿排可選原味或辣味，無備註會做原味；漢堡可加點起司或多加蔬菜。
居家累累、吃飽吃爽無罪！', '', '', 1, 0, 0, 1, UNHEX(REPLACE('13988bcf-9150-57f8-a015-d7a6fd4cd0c4', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('薯餅蛋', 55, '含蛋。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('651c5378-ccb4-5d91-84f2-41af63d3093f', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬排蛋', 55, '含蛋。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('e67802f1-a8b6-516f-898a-5c48eb34607d', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('薯泥蛋沙拉', 55, '含蛋。
自家製馬鈴薯泥。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('8a59a48b-560a-5166-a7e6-58303a9bd3cb', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('特製辣蝦🔥', 60, '含蛋。', '', '小辣', 1, 0, 0, 1, UNHEX(REPLACE('225871db-a70f-56ce-b907-1794fc8fbaaa', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鮭魚起司', 60, '含蛋。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('381400fc-c1a9-52e5-86bc-a399836846b1', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('蒜香辣燻雞🔥', 65, '含蛋。', '', '小辣', 1, 0, 0, 1, UNHEX(REPLACE('5bd5427c-f3d3-5ccd-b175-92ae71145fcb', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('辣鮪魚薯餅蛋🔥👍🏼', 65, '蔬菜有洋蔥、高麗菜絲，不加辣請在附註註明～', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c5b501fb-2004-516b-b690-c431612ec748', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('塔香豬排蛋👍🏼', 65, '黑胡椒豬排+九層塔蛋+特製醬', '', '', 1, 0, 0, 1, UNHEX(REPLACE('0b75e91e-7e19-5d17-890e-0a411071d858', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('辣鮪魚火腿蛋🔥', 65, '蔬菜有洋蔥、高麗菜絲，不加辣請在附註註明～', '', '', 1, 0, 0, 1, UNHEX(REPLACE('e5c951ac-3721-561d-8e48-1575b4a51a28', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泰甜辣蝦排蛋👍🏼', 65, '炸蝦排、蛋、洋蔥、高麗菜絲、泰式甜雞醬。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('22cdd4c1-8df6-52e1-b0a6-604137aab3f4', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('雙金鮪魚👍🏼', 70, '鮪魚、起司、厚玉米蛋、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c441609d-a60e-5bf4-bd35-46d5a917f01b', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泡菜辣培根🔥', 70, '韓式泡菜、培根、蛋、高麗菜絲、洋蔥。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('9f817897-e0ec-5821-80e9-ef003d9ab0b5', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬排薯餅蛋', 75, '豬排加整片薯餅。蔬菜部分有洋蔥、高麗菜絲', '', '', 1, 0, 0, 1, UNHEX(REPLACE('ea9fff80-5d6b-576d-a237-f6e9b2b6a0cc', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬肉起司辣薯🔥👍🏼', 75, '漢堡肉、起司、薯餅、蛋、洋蔥、高麗菜絲加上特製辣醬。若需不辣可在備註註明：）', '', '', 1, 0, 0, 1, UNHEX(REPLACE('8caca462-18b8-5852-9d22-44dc6c9db21d', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('花生醬雙培根起司蛋', 75, '含蛋。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('16ef96cb-f587-5a33-ad87-15c1a2a89ed9', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('川麻燒豬', 75, '含蛋。', '', '小辣', 1, 0, 0, 1, UNHEX(REPLACE('2497f268-82ee-5294-90b4-961987d9157b', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泰式醬雞柳起司蛋堡', 75, '檸檬雞柳、起司、蛋、洋蔥、高麗菜絲、泰式醬。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c4d860ed-a692-5e5a-91f7-1977a9376df6', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('蒜辣雙培根蛋🔥', 75, '含蛋。', '', '小辣', 1, 0, 0, 1, UNHEX(REPLACE('ff476654-d72e-5a2f-bccc-f7573bd3c92c', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('辣培根薯泥起司蛋🔥👍🏼', 80, '含蛋。', '', '小辣', 1, 0, 0, 1, UNHEX(REPLACE('5c870933-2b01-5ee8-a3e4-1bdf80503427', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬排薯泥玉米蛋', 95, '豬排片、自家製薯泥、玉米煎蛋、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('2b10fcfd-04d9-5d45-9d18-ba8c3d7eeb61', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鮪魚總匯', 70, '鮪魚、火腿、蛋、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('a5755333-19d2-5543-b73f-5697d404c782', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬肉總匯', 70, '漢堡肉、蛋、火腿、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('845bc3e7-61ed-5c6a-ae0c-cc5681b66f4d', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香雞總匯', 70, '香雞、蛋、火腿、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('e472b4a7-4fc8-5cd8-b9dd-0ae9e226114c', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('雙金鮪魚總匯', 80, '鮪魚、起司、厚玉米蛋、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c8001424-59ec-584b-9afa-c73560d52515', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('黑椒豬排總匯', 80, '黑胡椒豬排片、蛋、火腿、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('21c67cfa-7cf7-534a-84a7-9fb1614c322b', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('美式總匯👍🏼', 80, '薯餅、培根、起司、蛋、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('bfa2fadb-9cc2-5e74-b247-821326dbf62b', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鮭魚起司總匯', 85, '鮭魚排、起司、蛋、火腿、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('360448cd-8edc-5852-99cc-9a39eb0b3b69', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('特製辣蝦總匯🔥', 85, '蝦排加特製辣醬、火腿、蛋、高麗菜絲、洋蔥、起司。
做不辣OK、請幫我附註寫下～', '', '', 1, 0, 0, 1, UNHEX(REPLACE('a147013e-5417-5211-9230-03b1694966ef', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('海陸總匯👍🏼', 90, '鮪魚、豬排、蛋、火腿、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('9c537616-7142-55a6-a7b7-9c3baab72d89', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('藍帶豬排總匯', 90, '藍帶豬排、蛋、火腿、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('f66e3b8a-d339-54e4-9a7a-38e254af6c45', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬排薯餅總匯', 95, '豬排、整片薯餅、火腿、蛋、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('6816c5a9-6dff-5fe1-982f-bd691792984a', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('雙層豬肉起司總匯👍🏼', 95, '兩層漢堡肉、蛋、火腿、起司、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('876d7e25-1dca-5509-8b0e-619e79f8d204', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泰式蝦排起司總匯', 95, '炸蝦排、起司、蛋、泰式甜辣醬、火腿、洋蔥、高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('ee2d449c-223f-5174-a27a-c367bd47bdd3', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('塔香雙豬排總匯👍🏼', 105, '兩片豬排、九層塔蛋、火腿、洋蔥、高麗菜絲，加特製醬。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('342df967-d09c-5121-9f6b-0a25c1403df7', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬肉蛋餅', 45, '漢堡肉。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('851056e0-c07d-5459-90a0-6696d4103409', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('香雞蛋餅', 45, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('8818a6d9-579e-5012-8867-ee499e5d7f1d', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('蔬菜起司蛋餅👍🏼', 50, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('bc755ae2-9266-53b2-b44b-4b08221214e5', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('薯餅蛋餅', 55, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('ed915075-12c4-5f17-a123-194671e86807', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('燻雞蛋餅', 55, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('b55f5769-e2aa-578a-9bda-e0d58b911456', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('檸檬雞柳蛋餅', 55, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c90b04d6-e3cd-5b67-aa68-ad18756fb341', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鮪魚玉米蛋餅👍🏼', 60, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('664e440d-7ddf-5cfb-a217-30d27391604d', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('塔香豬排蛋餅', 65, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('aaa414e9-6a14-5139-af5e-1941f6eb5b65', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('薯泥培根蛋餅👍🏼', 70, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('04d21342-fbde-5591-9d43-4c90353a7e03', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('川麻豬五花蛋餅🔥', 75, '小辣，含高麗菜絲。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('b95f51c1-1e76-59fa-83cb-654652ea205c', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('美式蛋餅👍🏼', 80, '薯餅、培根、起司', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c13edc8f-ce12-5670-8792-d5f22917d7da', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泡菜豬排蛋餅', 80, '韓式泡菜，本身微辣而已。
泡菜本身就有鹹所以醬會放旁邊少些，口味重需要加醬多的再麻煩幫我備註，謝謝～
喜歡吃辣的建議再加上我們的特製辣椒讚讚的！', '', '', 1, 0, 0, 1, UNHEX(REPLACE('acb6c134-1ca1-50b7-b5de-50930f5aad84', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('玉米蛋抓餅', 55, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('e9e0d438-cbe4-5bb0-b77b-e8b3b38f4fc8', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('起司蛋抓餅', 55, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('2bc34079-1b61-5bf9-b7ac-e4298884662f', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('火腿蛋抓餅', 60, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('09c69017-fc35-5ecf-8614-362822be2e72', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('肉鬆蛋抓餅', 60, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('64a9fe50-1b38-5db7-8195-885a2eaf8920', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('鮪魚蛋抓餅', 60, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('f230b8c8-465b-5bc4-8f4f-f423b79ea499', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('培根蛋抓餅👍🏼', 60, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('8ea98aac-e8db-573a-8ce6-145f508cb111', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('豬肉蛋抓餅', 60, '漢堡肉。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('0fbfae07-1a80-5f70-b1ee-9245c63256b6', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泰式醬蔬菜蛋抓餅', 60, '洋蔥、玉米、高麗菜絲、泰式甜辣醬。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('d4bbcd7a-7733-5ac0-8dc6-eaa9a5dcd686', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('薯餅蛋抓餅', 65, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c79cbe8e-72ab-5402-80c1-7fdd697b2172', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('燻雞蛋抓餅', 65, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('d0a8d485-8b06-5732-aef2-293650beb2db', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('洋蔥起司蛋抓餅👍🏼', 65, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('cc0bf85c-4130-5cd1-b9ed-3f677b8ca67d', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('檸檬雞柳蛋抓餅', 65, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('db8185a2-e165-57e1-a350-c02c0b64dda6', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('黑椒豬排蛋抓餅', 65, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('c8ceccd0-baa4-5ba5-902f-f8d136e6e2cd', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('薯泥培根蛋抓餅', 80, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('f4e07abb-810c-5a7b-8dae-aa9c36a9b6a1', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('泡菜豬排蛋抓餅', 85, '韓式泡菜，本身微辣而已。
泡菜本身就有鹹所以醬會放旁邊少些，口味重需要加醬多的再麻煩幫我備註，謝謝～
喜歡吃辣的建議再加上我們的特製辣椒讚讚的！', '', '', 1, 0, 0, 1, UNHEX(REPLACE('50d14f35-629c-5e79-b883-096fe7307f3b', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('荷包蛋', 15, '不需油膏請備註，謝謝。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('b1cdbcf5-b0fd-5d40-9484-66d3bc30c212', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('熱狗', 35, '一份4隻。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('a94019c2-c5bf-547f-8664-34b3bfe6b7eb', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('雞塊', 40, '一份5個。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('41aeb6aa-3f16-56df-ab1c-f00c83f17d7d', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('脆薯', 40, '一份100g。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('d48a53a8-191b-5d2b-8f17-8ca708f5b1c9', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('煎餃', 50, '一份10顆。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('3f3ac532-3a22-5ca9-b480-ac2f6e8e9385', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('卡拉卡拉塔', 120, '肉肉肉肉肉！「兩塊」卡拉雞腿排疊一起，中間夾培根和起司，加些許洋蔥和高麗菜絲解膩！沒有多餘麵包負擔，肉控的最愛！
＊可選原味或辣味，若無備註會做原味。

蠻肥的，建議真心喜愛肉肉的再點ＸＤ', '', '', 1, 0, 0, 1, UNHEX(REPLACE('87bb60fa-6db9-57f3-95bc-bfcc02791974', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('需要吸管', 0, '平台選不用免洗餐具的話就都不會付，需要吸管的話請幫我們附註謝謝 ； ）', '', '', 1, 0, 0, 1, UNHEX(REPLACE('a09fbfd0-edff-521b-b886-adc59e9c9caf', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('奶茶', 30, '大杯。甜度固定，但不會太甜。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('2e406beb-cf55-5a4f-bcf3-17db40125c64', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('無糖冰豆漿', 30, '大杯。
豆漿只有無糖的，沒辦法另外加，謝謝！
*暫不提供溫豆漿、熱豆漿。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('a2ef4d4c-3634-5d4a-be43-788803d941cf', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('研磨咖啡', 45, '', '', '', 1, 0, 0, 1, UNHEX(REPLACE('05f5a500-4138-564b-b0f8-54228bb1d372', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('拿鐵', 55, '使用「義美鮮乳」，可多加一份鮮乳+15元。', '', '', 1, 0, 0, 1, UNHEX(REPLACE('2776dfbc-5fbd-5d61-9318-ea7e3fb5d6ce', '-', '')), 3);
INSERT IGNORE INTO `Table_Good` (`name`, `price`, `discription`, `image_suffix`, `spicy_level`, `is_emphasis`, `is_discount`, `is_exclusive`, `is_show`, `uuid`, `shop_id`) VALUES ('燕麥豆奶拿鐵', 65, '大杯。
我們使用「義美燕麥全豆奶」加研磨咖啡！ 有乳糖不耐、怕胖、全素、怕長痘痘，總之不喝鮮奶的都可以試試！', '', '', 1, 0, 0, 1, UNHEX(REPLACE('a9fbb120-6742-59fa-b600-17c10be40753', '-', '')), 3);


INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (6, 1);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (1, 1);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (7, 1);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (8, 2);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (2, 2);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (9, 2);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (1, 2);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (5, 3);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (10, 3);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (11, 3);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (3, 4);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (12, 4);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (13, 5);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (6, 5);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (7, 6);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (14, 6);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (15, 7);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (4, 7);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (16, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (17, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (18, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (19, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (20, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (21, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (22, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (23, 8);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (24, 9);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (25, 9);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (26, 9);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (27, 10);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (28, 10);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (29, 11);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (35, 12);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (36, 12);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (37, 13);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (38, 13);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (39, 13);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (40, 13);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (41, 13);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (42, 14);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (43, 14);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (44, 14);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (45, 14);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (46, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (47, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (48, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (49, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (50, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (51, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (52, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (53, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (54, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (55, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (56, 15);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (57, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (58, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (30, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (59, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (60, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (61, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (62, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (63, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (64, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (65, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (66, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (67, 16);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (68, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (69, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (31, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (34, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (70, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (71, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (72, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (73, 17);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (74, 18);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (75, 18);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (76, 18);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (77, 18);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (33, 19);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (78, 19);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (85, 20);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (86, 20);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (87, 20);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (88, 20);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (89, 20);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (90, 21);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (91, 22);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (92, 22);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (93, 22);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (94, 23);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (95, 23);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (96, 23);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (97, 23);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (98, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (99, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (100, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (101, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (102, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (103, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (104, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (105, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (106, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (107, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (108, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (109, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (110, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (111, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (112, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (113, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (114, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (115, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (116, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (117, 24);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (118, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (119, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (120, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (121, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (122, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (123, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (124, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (125, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (126, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (127, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (128, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (129, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (130, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (131, 25);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (132, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (133, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (134, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (135, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (136, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (137, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (138, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (139, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (140, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (141, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (142, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (143, 26);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (144, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (145, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (146, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (147, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (148, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (149, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (150, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (151, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (152, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (153, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (154, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (155, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (156, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (157, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (158, 27);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (79, 28);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (159, 28);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (160, 28);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (161, 28);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (162, 28);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (163, 28);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (164, 28);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (165, 29);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (166, 29);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (167, 29);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (168, 29);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (169, 29);
INSERT IGNORE INTO `Table_Mapping_Good_And_Channel` (`good_id`, `channel_id`) VALUES (170, 29);


INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (4, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (5, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (7, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (9, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (10, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (11, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (12, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (13, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (1, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (2, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (3, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (4, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (5, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (6, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (7, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (8, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (14, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (15, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (16, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (17, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (18, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (19, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (20, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (1, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (21, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (22, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (4, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (23, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (24, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (25, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (26, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (27, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (22, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (4, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (28, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (29, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (30, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (12, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (31, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (32, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (33, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (34, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (35, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (36, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (37, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (38, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (39, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (40, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (41, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (42, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (43, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (44, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (45, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (46, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (47, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (48, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (49, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (50, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (51, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (52, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (53, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (54, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (55, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (56, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (57, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (58, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (59, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (60, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (61, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (62, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (63, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (64, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (65, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (66, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (67, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (68, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (69, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (70, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (71, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (72, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (73, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (74, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (75, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (76, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (77, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (59, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (78, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (79, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (80, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (81, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (82, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (83, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (84, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (85, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (86, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (87, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (88, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (34, 15);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (89, 15);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (90, 15);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (85, 15);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (91, 15);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Channel` (`shop_id`, `channel_id`) VALUES (92, 15);



INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (99, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (100, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (101, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (102, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (103, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (104, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (105, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (106, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (107, 1);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (108, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (109, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (110, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (111, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (112, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (113, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (114, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (115, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (116, 2);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (115, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (110, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (117, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (91, 3);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (118, 4);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (119, 5);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (120, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (121, 6);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (122, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (123, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (124, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (120, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (125, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (121, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (126, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (119, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (127, 7);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (22, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (4, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (28, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (29, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (30, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (12, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (31, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (32, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (123, 8);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (128, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (81, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (129, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (130, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (131, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (132, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (133, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (134, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (135, 9);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (162, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (163, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (164, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (165, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (166, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (167, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (168, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (169, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (170, 10);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (171, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (172, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (173, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (174, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (175, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (176, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (177, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (178, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (83, 11);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (136, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (137, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (138, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (139, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (140, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (141, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (142, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (143, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (144, 12);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (154, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (83, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (155, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (156, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (157, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (158, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (159, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (160, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (161, 13);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (145, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (146, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (147, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (148, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (149, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (150, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (151, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (152, 14);
INSERT IGNORE INTO `Table_Mapping_Shop_And_Category` (`shop_id`, `category_id`) VALUES (153, 14);

