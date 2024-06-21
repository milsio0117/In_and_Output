* 特定の文字を含むデータを検索
```sql
  SELECT *
  FROM purchases
  WHERE name LIKE "%プリン%";  --前後に文字OK
```

* 含まない、一致しないデータ
```sql
  SELECT *
  FROM purchases
  WHERE NOT name LIKE "%プリン%";

  SELECT *
  FROM purchases
  WHERE NOT price > 1000;  --1000円以下のデータ
```

* 空欄のデータ
```sql
  SELECT *
  FROM purchases
  WHERE price IS NULL;
```

* 空欄でないデータ
```sql
  SELECT *
  FROM purchases
  WHERE price IS NOT NULL;
```

* 複数の条件
```sql
  SELECT *
  FROM purchases
  WHERE category = "食費"
  AND character_name ="しお";  --ORだと 食費またはしお
```

* 並べ替える
```sql
  SELECT *
  FROM purchases
  ORDER BY price DESC;
```

* 重複するデータを除く
```sql
  SELECT DISTINCT(name)  --(カラム名)
  FROM purchases;
```

* 平均を計算
```sql
  SELECT AVG(price)
  FROM purchases
  WHERE character_name ="しお"
```

* カラムのデータの合計数を計算
```sql
  SELECT COUNT(name)
  FROM purchases;
```
