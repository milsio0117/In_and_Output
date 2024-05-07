## before_action
定義されたアクションが実行される前に共通の処理を行う
```
        class コントローラ名 < ApplicationController
            before_action :処理させたいメソッド名
```
例
```
class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
```

→:edit, :show  が呼び出される前にこれが呼ばれる。edit,showにはdef endだけ書く

```
def edit
end
```
privateに `def set_tweet`を定義しておく  
<br>

> [!NOTE]
>ログインしていないユーザーをindexに飛ばしたい時の記述  
`before_action :set_tweet, except:[:index]`
```
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
```
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
```
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
```
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

```
      def index
        @tweets = Tweet.includes(:user).order("created_at DESC")
      end
```
