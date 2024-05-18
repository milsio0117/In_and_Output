## 削除ボタン(destroy) 
httpメソッドは`data: { turbo_method: :delete }`
```ruby
<%= link_to '削除', "tweet_path(tweet.id)", data: { turbo_method: :delete } %>
```
<br><br><br>

## before_action
定義されたアクションが実行される前に共通の処理を行う
```ruby
        class コントローラ名 < ApplicationController
            before_action :処理させたいメソッド名
```
例
```ruby
class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
```

→:edit, :show  が呼び出される前にこれが呼ばれる。edit,showにはdef endだけ書く

```ruby
def edit
end
```
privateに `def set_tweet`を定義しておく  
<br>

> [!NOTE]
>ログインしていないユーザーをindexに飛ばしたい時の記述  
`before_action :set_tweet, except:[:index]`
```ruby
before_action :set_tweet, except:[:index]

private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
```
indexにアクセスするとループとなるため除外する必要があるため
`except:[:index]`
を追加すると、indexを除いたほかの全てで実行される
<br><br><br>

## ストロングパラメーター
`params.require(:モデル名).permit(:許可するキー)`  
→ params.require(:post).permit(:image, :text) 
<br><br>

## devise_parameter_sanitizer
* deviseのコントローラーは触れないため`apprication_controller.rb`に書く
* Application_Controller : 全てのコントローラーがここを読み込むファイル。ここに書くとすべてのコントローラーで共通の処理をする
* permitメソッドを組み合わせることでdeviseに定義されているストロングパラメーターに対し自分で新しく追加したカラムも指定して含めることができる
* Application_Controllerでdeviseのコントローラーだけに読み込ませる場合  
`→ before_action :configure_permitted_parameters, if: :devise_controller?`を追記
<br>

`devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])`  
→ devise_parameter_sanitizer.permit(:sign_up, keys: [:name])  
処理名はsign_up,sign_inなどdeviseで決められたものがある

例
```ruby
before_action :configure_permitted_parameters, if: :devise_controller?
    
private
    def configure_permitted_parameters  # メソッド名は慣習
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])　# deviseのUserモデルにパラメーターを許可
　　end
end
```
<br><br><br>

## render
ルーティングを経ずにビューが表示される→ 元のインスタンス変数は上書きされない（フォーム内容を維持したまま画面に戻る）
```ruby
def update
        if current_user.update(user_params)
              redirect_to root_path
        else
              render :edit, status: :unprocessable_entity
        end
end
```
<br><br><br>

## authenticate_user! (apprication controller)
* ログイン状態により表示ページを切り替えるdeviseのメソッド
* authenticate_user!処理が呼ばれた段階でユーザーがログインしていなければそのユーザーをログイン画面に遷移させる
```ruby
 class ApplicationController < ActionController::Base
     before_action :authenticate_user!
 end
```
<br><br><br>

## 並び順を変える
`インスタンス = モデル名.order("並び替えの基準となるカラム名 並び順")`
* レコードの取得順を変える  
* DESC :降順（新→古）
* ASC :昇順（古→新）

```ruby
      def index
        @tweets = Tweet.includes(:user).order("created_at DESC")
      end
```
<br><br><br>

## flashメッセージを表示させる
例：記事の作成に成功した後に成功メッセージを表示する
```ruby
        def create
          @article = Article.new(article_params)
          if @article.save
            flash[:notice] = "作成に成功しました"
            redirect_to @article
          else
            render :new
          end
        end
```
redirect_toの場合は省略形でも書ける
```ruby
redirect_to @article, notice: "作成に成功しました"

redirect_to root_url, alert: "ログインに問題が起こりました"
```


ビューファイル
```ruby
         <% if flash[:notice] %>
              <div class="flash">
                <%= flash[:notice] %>
```

notice,alert以外を定義する(apprication.html.erb)
```ruby
        <% flash.each do |name, msg| %>
          <%= content_tag :div, msg, class: "flash_#{name}" %>
        <% end %>
```
→ flash[:success] = "作成に成功しました"  
　flash[:error] = "失敗しました"  
 なども使えるようになる。.flash_success、.flash_errorのclassも定義できる。
 <br><br><br>
