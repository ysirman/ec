# ECサービスのAPI
* ユーザーが商品を購入するとき
  * 商品（Item）の販売状態（Item.on_sale）を更新する（販売中：true => 売切：false）
  * 購入者のポイント（User.point）を商品価格（Item.price）の分だけマイナスする
  * 出品者のポイント（User.point）を商品価格（Item.price）の分だけプラスする

## ER図
![Entity Relationship Diagram](https://user-images.githubusercontent.com/24975537/70912950-5eeca780-2058-11ea-9da0-77b041c91b0b.png)