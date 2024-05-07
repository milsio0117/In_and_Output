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
<br><br>

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


## devise_parameter_sanitizer
* permitメソッドを組み合わせることでdeviseに定義されているストロングパラメーターに対し自分で新しく追加したカラムも指定して含めることができる
* deviseのコントローラーは触れないため`apprication_controller.rb`に書く
* Application_Controller : 全てのコントローラーがここを読み込むファイル。ここに書くとすべてのコントローラーで共通の処理をする。
* deviseのコントローラーだけに読み込ませる場合
→ `before_action :configure_permitted_parameters, if: :devise_controller?`を追記
```
    paramsのpermitメソッド
    params.require(:モデル名).permit(:許可するキー)
            ↓
    devise_parameter_sanitizerのpermitメソッド
    devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])
```
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

## authenticate_user! (apprication controller)
* ログイン状態により表示ページを切り替えるdeviseのメソッド
* authenticate_user!処理が呼ばれた段階でユーザーがログインしていなければそのユーザーをログイン画面に遷移させる
```
 class ApplicationController < ActionController::Base
     before_action :authenticate_user!
 end
```
