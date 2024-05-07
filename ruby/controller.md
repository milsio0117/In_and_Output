### before_action
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
```
private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
```
とした場合、indexにアクセスするとループとなるため除外する必要がある  
`→ before_action :set_tweet, except:[:index]`
この場合indexを除いたほかの全てで実行される
