## collection,member
* 使い分け→どの種類のルーティングが必要か（全体or特定）
* 生成されるルーティングのURLと実行されるコントローラーを任意にカスタムできる
* 詳細ページのような:id を指定して特定のページにいく必要がなければ（例：検索）collectionでよい。検索でも特定のリソース内での検索だとmember  
<br>

collectionルートはリソース全体に対して作用
```ruby
        resources :tweets do
          collection do
            get 'search'
          end
        end
```

→ 得られるルーティング: `search_tweets    GET    /tweets/search(.:format)   tweets#search`  
<br>

memberルートは特定の1つのリソースに対して作用 → 特定のリソースに対するアクションなど
```ruby
        resources :tweets do
          member do
            get 'search'
          end
        end
```

→ 得られるルーティング: `search_tweet      GET    /tweets/:id/search(.:format)   tweets#search`
