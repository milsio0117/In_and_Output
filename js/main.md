### 日付の取得（YYYY-MM-DD）
```js
   const date = new Date(item.created_at);
   const formattedDate = `${date.getFullYear()}-
　　　${(date.getMonth()+1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`
```

* date.getFullYear()：年を4桁の数字で返す。2022年であれば「2022」を返す。

* (date.getMonth()+1).toString().padStart(2, '0')：  
  getMonthメソッドは0（1月）から11（12月）までの範囲で月を返すため、+1をして1から12の範囲に調整する。その後、toStringメソッドで数値を文字列に変換し、padStart(2, '0')で1桁の場合に左側を0で埋めて2桁に揃える。

* date.getDate().toString().padStart(2, '0')：  
  getDateメソッドは日にちを返す（1から31）。処理は月と同様。
