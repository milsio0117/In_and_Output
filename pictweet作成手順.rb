アプリの雛形を生成： rails new アプリケーション名 -オプション名
    ターミナル: rails _7.0.0_  new 
    ・バージョンを指定しなければインストールされている最新が使われる
    ・オプション「-d mysql」:作成するアプリが利用するデータベースの管理システムの種類を指定できる


データベースを生成: rails db:create
    ・データベースを削除する場合はrails db:drop


データベースを可視化: DBeaver
    ・データベース→新しい接続 → MySQL → 設定特になければ右下終了


アプリのサーバーを起動: rails s
    ・もうひとつターミナルを開きそちらに記述を始める


ルーティング設定: config/routes.rb
    Rails.application.routes.draw do
        HTTPメソッド 'URIパターン', to: 'コントローラー名#アクション名'
    end

    ・例
    Rails.application.routes.draw do
        get 'posts', to: 'posts#index'
    end


ルーティングを確認: rails routes


コントローラーを生成: rails g ファイルの種類(ここではコントローラー) 生成するファイル名（コントローラー名・複数形）
    rails g controller posts
    →  app/controllers/posts_controller.rbができる
    ・ファイルごと削除する場合: rails d


アクションを定義: controllers/posts_controller.rb
    class PostsController < ApplicationController

        def index  # indexアクションを定義した
        end
   
    end

ビューファイルを作成: app/views/posts
    ・データをHTMLでも使用したいときはRubyを埋め込むことができるERBという仕組みを使用 .erb
    ・index.html.erb  posts内に作成する

モデルを作成: rails g model モデル名(単数形)
    rails g model post

マイグレーションを編集してどのようなテーブルにするか決める:
  db/migrate/20XXXXXXXXXXXX_create_posts.rb
    class CreatePosts < ActiveRecord::Migration[7.0]
        def change
        create_table :posts do |t|
         t.text :memo #コメント
         t.timestamps #作成時間
         end
        end 
     end

    ・integer	数値	金額、回数など
    ・string	文字(短文)	ユーザー名、メールアドレスなど
    ・text	文字(長文)	投稿文、説明文など
    ・boolean	真か偽か	はい・いいえの選択、合格・不合格のフラグなど
    ・datetime	日付と時刻


マイグレーションを実行: rails db:migrate
     →first_app_developmentデータベース内に「posts」テーブル、「memo」カラムが作成される
     ・戻したいときは: rails db:rollback
     ・マイグレーションが実行済みであるかをファイルごとに調べるコマンド:
       rails db:migrate:status  upかdownで表記


コンソールでデータを追加
     ・rails cでコンソール起動→ irbが起動される
     irb(main):001:0> post = Post.new
     irb(main):002:0> post.content = "こんにちは！"
     irb(main):003:0> post.save
     irb(main):007:0> exit

     ActiveRecord : モデルがテーブル操作に関して使用できるメソッドの総称
     例) Post.all
     all	テーブルのすべてのデータを取得する
     find	引数にレコードのidを指定し、対応するレコードを取得する
     new	クラスのインスタンス（レコード）を生成する
     save	クラスのインスタンス（レコード）を保存する

コントローラーで単一レコードを取得 : app/controllers/posts_controller.rb
    class PostsController < ApplicationController
        def index
        @post = Post.find(1)  # 1番目のレコードを@postに代入
        end
    end

ビューで単一レコードのカラムデータを表示 : app/views/posts/index.html.erb
    <%= @post.content %>      >
    ・レコード全部を表示（@postだけ）させようとするとエラーになる。
    ・必要なら<%= @post.content %>   >
             <%= @post.created_at %>   >  といくつか分ける

ビューで複数レコードのカラムデータを表示 : app/views/posts/index.html.erb
        <%= @posts.content %>  >
        <%= @posts.created_at %>  >変数名は分かりやすいように複数形にしておく
        すべて取得した場合全部を表示させようとするとエラーになる
        → <% @posts.each do |post| %>  >
            <%= post.content %>  >
            <%= post.created_at %>  >
            <% end %>  >


ビューファイルの見た目を整える : app/views/posts/index.html.erb
        <% @posts.each do |post| %>  >
            <div class="post">
            <div class="post-date">
                投稿日時：<%= post.created_at %>  >
            </div>
            <div class="post-content">
                <%= post.content %>  >
            </div>
            </div>
        <% end %>  >

        → cssファイルを作成 : app/assets/stylesheetsに posts.cssを作り編集する


投稿ページ作成
    **ルーティングを設定 : config/routes.rb
        Rails.application.routes.draw do
            get 'posts', to: 'posts#index'
            get 'posts/new', to: 'posts#new'
        end

    **アクションを定義 : app/controllers/posts_controller.rb
        class PostsController < ApplicationController
            def index
            @posts = Post.all
            end
        
            def new     # ここが追加された
            end
        end

    **ビューファイルを作成 :
        app/views/postsディレクトリに、new.html.erbを作成

    **ビューにフォームを作成
        <%= form_with url: "/posts", method: :post, local: true do |form| %>  >
            <%= form.text_field :content %>  >
            <%= form.submit '投稿する' %>  >
        <% end %>  >
        ・local :リモート送信を無効にするかどうかを指定。trueにすると無効
        ・method :フォームの情報を送るリクエストのHTTPメソッドを指定。オプションの初期値は:post なのでpostメソッドを指定する場合は省略することが可能

    **リンクを作成する : 
        <%= link_to 'リンクに表示する文字', 'リンク先のURL' %> >  または
        <%= link_to 'リンクに表示する文字', 'パス', method: :HTTPメソッド %>  >

    **ビューファイルにリンクを追加
        ・どのリクエストの情報を埋め込めば良いか考える。rails routesを実行して、設定したルーティングを確認
        → posts_new   GET     /posts/new(.:format)  posts#new   ←例：これに入れる場合
        
        <%= link_to '新規投稿', '/posts/new' %> >  #ここが追加文
        <% @posts.each do |post| %> >
        <div class="post">
            <div class="post-date">
            投稿日時：<%= post.created_at %>    >
            </div>
            <div class="post-content">
            <%= post.content %> >
            </div>
        </div>
        <% end %>   >


投稿完了ページ作成
        **ルーティングを設定 : config/routes.rb
        Rails.application.routes.draw do
            get 'posts', to: 'posts#index'
            get 'posts/new', to: 'posts#new'
            post 'posts', to: 'posts#create'  #ここが追加文
        end

        **アクションを定義 : app/controllers/posts_controller.rb
        class PostsController < ApplicationController
            def index
              @posts = Post.all
            end
          
            def new
            end
          
            def create  #ここが追加文
            end
          end

        **アクションに保存の処理を書く: app/controllers/posts_controller.rb
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