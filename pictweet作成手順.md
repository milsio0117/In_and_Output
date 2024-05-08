#### アプリの雛形を生成
`rails new アプリケーション名 -オプション名`  
* ターミナル: rails 7.0.0 new (バージョン指定する場合。数字の前後はアンダーバー)  
* バージョンを指定しなければインストールされている最新が使われる  
* オプション「-d mysql」:作成するアプリが利用するデータベースの管理システムの種類を指定できる
<br><br>

#### データベースを生成
`rails db:create`
* データベースを削除する場合は`rails db:drop`
<br><br>

#### データベースを可視化 : DBeaver
* データベース→新しい接続 → MySQL → 設定特になければ右下終了
<br><br>

#### アプリのサーバーを起動
`rails s`
* もうひとつターミナルを開きそちらに記述を始める
<br><br>

#### ルーティング設定 : config/routes.rb
```ruby
    Rails.application.routes.draw do
        HTTPメソッド 'URIパターン', to: 'コントローラー名#アクション名'
    end
```
例
```ruby
    Rails.application.routes.draw do
        get 'posts', to: 'posts#index'
    end
```
<br><br>

#### ルーティングを確認 
`rails routes`
<br><br>

#### コントローラーを生成
`rails g ファイルの種類(ここではコントローラー) 生成するファイル名（コントローラー名・複数形）`
```
rails g controller posts
```
→  app/controllers/posts_controller.rbができる
* ファイルごと削除する場合: `rails d controller posts`
<br><br>

#### アクションを定義 : controllers/posts_controller.rb
```ruby
    class PostsController < ApplicationController
        def index  # indexアクションを定義した
        end
    end
```
<br><br>

#### ビューファイルを作成 : app/views/posts
* データをHTMLでも使用したいときはRubyを埋め込むことができるERBという仕組みを使用 .erb
* `index.html.erb` posts内に作成する
<br><br>

#### モデルを作成
`rails g model モデル名(単数形)`  
例
```
rails g model post
```
<br><br>

#### マイグレーションを編集してどのようなテーブルにするか決める
```ruby
  db/migrate/20XXXXXXXXXXXX_create_posts.rb
    class CreatePosts < ActiveRecord::Migration[7.0]
        def change
        create_table :posts do |t|
         t.text :memo #コメント
         t.timestamps #作成時間
         end
        end 
     end
```

```ruby
    ・integer	数値	    金額、回数など
    ・string	文字(短文)	ユーザー名、メールアドレスなど
    ・text      文字(長文)	投稿文、説明文など
    ・boolean	真か偽か	はい・いいえの選択、合格・不合格のフラグなど
    ・datetime	日付と時刻
```
<br><br>

#### マイグレーションを実行
`rails db:migrate`
→first_app_developmentデータベース内に「posts」テーブル、「memo」カラムが作成される
* 戻したいときは`rails db:rollback`
* マイグレーションが実行済みであるかをファイルごとに調べる:`rails db:migrate:status` upかdownで表記
<br><br>

#### コンソールでデータを追加
* rails cでコンソール起動→ irbが起動される
```
     irb(main):001:0> post = Post.new
     irb(main):002:0> post.content = "こんにちは！"
     irb(main):003:0> post.save
     irb(main):007:0> exit
```
<br><br>

#### コントローラーで単一レコードを取得 : app/controllers/posts_controller.rb
```ruby
    class PostsController < ApplicationController
        def index
        @post = Post.find(1)  # 1番目のレコードを@postに代入
        end
    end
```
<br><br>

#### ビューで単一レコードのカラムデータを表示 : app/views/posts/index.html.erb
`<%= @post.content %>`  
レコード全部を表示（@postだけ）させようとするとエラーになる。  
必要なら
```ruby
    <%= @post.content %>
    <%= @post.created_at %>
```
といくつか分ける
<br><br>

#### ビューで複数レコードのカラムデータを表示 : app/views/posts/index.html.erb
```ruby
        <%= @posts.content %>
        <%= @posts.created_at %>
```
* 変数名は分かりやすいように複数形にしておく
* すべて取得した場合全部を表示させようとするとエラーになる
```ruby
        <% @posts.each do |post| %>
            <%= post.content %>
            <%= post.created_at %>
        <% end %>
```
<br><br>

#### ビューファイルの見た目を整える : app/views/posts/index.html.erb
```ruby
        <% @posts.each do |post| %>
            <div class="post">
            <div class="post-date">
                投稿日時：<%= post.created_at %>
            </div>
            <div class="post-content">
                <%= post.content %>
            </div>
            </div>
        <% end %>
```
→ cssファイルを作成 : app/assets/stylesheetsに posts.cssを作り編集する
<br><br>

#### 投稿ページ作成 
1. ルーティングを設定: config/routes.rb
```ruby
        Rails.application.routes.draw do
            get 'posts', to: 'posts#index'
            get 'posts/new', to: 'posts#new'
        end
```
<br>

2. アクションを定義 : app/controllers/posts_controller.rb
```ruby
        class PostsController < ApplicationController
            def index
            @posts = Post.all
            end
        
            def new     # ここが追加された
            end
        end
```
<br>

3. ビューファイルを作成  
app/views/postsディレクトリにnew.html.erbを作成
<br>

4. ビューにフォームを作成
```ruby
        <%= form_with url: "/posts", method: :post, local: true do |form| %>
            <%= form.text_field :content %>
            <%= form.submit '投稿する' %>
        <% end %>
```
* local :リモート送信を無効にするかどうかを指定。trueにすると無効  
* method :フォームの情報を送るリクエストのHTTPメソッドを指定。オプションの初期値は:post なのでpostメソッドを指定する場合は省略することが可能
<br>

5. リンクを作成する
```ruby
        <%= link_to 'リンクに表示する文字', 'リンク先のURL' %> または
        <%= link_to 'リンクに表示する文字', 'パス', method: :HTTPメソッド %>
```
<br>

6. ビューファイルにリンクを追加
* どのリクエストの情報を埋め込めば良いか考える。  
* rails routesを実行して、設定したルーティングを確認  
例：これに入れる場合 `posts_new   GET     /posts/new(.:format)  posts#new`
 ```ruby
        <%= link_to '新規投稿', '/posts/new' %> #ここが追加文
        <% @posts.each do |post| %>
        <div class="post">
            <div class="post-date">
            投稿日時：<%= post.created_at %>
            </div>
            <div class="post-content">
            <%= post.content %>
            </div>
        </div>
        <% end %> 
```
<br><br>

#### 投稿完了ページ作成
1. ルーティングを設定 : config/routes.rb
```ruby
        Rails.application.routes.draw do
            get 'posts', to: 'posts#index'
            get 'posts/new', to: 'posts#new'
            post 'posts', to: 'posts#create'  #ここが追加文
        end
 ```

12. アクションを定義 : app/controllers/posts_controller.rb
```ruby
        class PostsController < ApplicationController
            def index
              @posts = Post.all
            end
          
            def new
            end
          
            def create  #ここが追加文
            end
          end
```

3. アクションに保存の処理を書く: app/controllers/posts_controller.rb
```ruby
        class PostsController < ApplicationController
            def index
              @posts = Post.all
            end
          
            def new
            end
          
            def create
              Post.create(content: params[:content])   #ここが追加文
              redirect_to "/posts"     #投稿後に/postsにリダイレクトする
            end
          end
```
