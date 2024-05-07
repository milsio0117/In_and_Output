

## form_with
データベースに保存しない場合
```
<%= form_with url: "パス" do |form| %>
   <!--内容 -->
<% end %>
```
<br>

データベースに保存する場合
```
<%= form_with model: モデルクラスのインスタンス do |form| %>  #モデルクラスのインスタンス:コントローラーで定義
    <!--内容 -->
<% end %>
```
<br>

例：投稿フォームの作成
```
<%= form_with model: @user do |form| %>
  <%= form.text_field :name %>  #form.htmlタグ名  :カラム名
  <%= form.submit %>
<% end %>
```


## サインインの有無で条件分岐
`if user_signed_in?`  
例

```
<% if user_signed_in? %>
  <div class="user_nav grid-6">
     <%= link_to "ログアウト", destroy_user_session_path, data: { turbo_method: :delete } %>
     <%= link_to "投稿する", new_tweet_path, class: "post" %>
  </div>
<% else %>
  <div class="grid-6">
     <%= link_to "ログイン", new_user_session_path, class: "post" %>
     <%= link_to "新規登録", new_user_registration_path, class: "post" %>
  </div>
<% end %>
```
