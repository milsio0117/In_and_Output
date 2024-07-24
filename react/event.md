[https://ja.react.dev/learn]

## onChange
### フォームの入力や削除が行われたときに処理を実行する
```js
 <input onChange={()=>{処理}} />
```
入力値の取得はonChangeにeventという引数を追加し、event.target.valueとすると取得できる。
```js
 <input onChange={(event)=>{console.log(event.target.value)}}  //入力値が表示される
```

## onClick
### クリックされた時に処理を実行する
```js
 <button onClick={() => {処理}}></button>
```

## ひな形
### 
```js

```

## onChange
### フォームの入力や削除が行われたときに処理を実行する
```js

```
