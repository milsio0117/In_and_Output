# gem deviseの導入手順
```
1.gemfileにgem'devise'を入れる
2.bundle install
3.rails s    で再起動
4.rails g devise:install
5.rails g devise モデル名　→devise_for:usersが入る
6.rails db:migrate   ←migrate/xxxx_devise_create_users.rbでテーブルの設計確認後
7.rails sで再起動
8.rails g devise:views   必要なら編集
9.rails g migration AddNicknameToUsers nickname:string   （カラム追加が必要なら）
10.rails db:migrate
11.rails sで再起動
```


# deviseの削除手順
逆を行う
```
1.rails db:migrate:statusで状態を確認
2.rails db:rollback（downの場合。upならrails db:rollbackする）
3.rails d dvise:views
4.rails d devise user
5.rails d devise:install
```
controllerは普通に生成しないといけないのでrails g controller usersをする。  
(その前にresources :users をrouteに設定する→　pathが出る)  
→ views/users/ も自動的に作られる

