* 特定の文字を含むデータを検索
```sql
  SELECT *
  FROM purchases
  WHERE name LIKE "%プリン%";  --前後に文字OK
```
<br>

* 含まない、一致しないデータ
```sql
  SELECT *
  FROM purchases
  WHERE NOT name LIKE "%プリン%";

  SELECT *
  FROM purchases
  WHERE NOT price > 1000;  --1000円以下のデータ
```
<br>

* 空欄のデータ
```sql
  SELECT *
  FROM purchases
  WHERE price IS NULL;
```
<br>

* 空欄でないデータ
```sql
  SELECT *
  FROM purchases
  WHERE price IS NOT NULL;
```
<br>

* 複数の条件
```sql
  SELECT *
  FROM purchases
  WHERE category = "食費"
  AND character_name ="しお";  --ORだと 食費またはしお
```
<br>

* 並べ替える
```sql
  SELECT *
  FROM purchases
  ORDER BY price DESC;
```
<br>

* 重複するデータを除く
```sql
  SELECT DISTINCT(name)  --(カラム名)
  FROM purchases;
```
<br>

* 平均を計算
```sql
  SELECT AVG(price)
  FROM purchases
  WHERE character_name ="しお"
```
<br>

* カラムのデータの合計数を計算
```sql
  SELECT COUNT(name)
  FROM purchases;
```
<br>

* 最小、最大を検索
```sql
  SELECT MAX(price)
  FROM purchases;

  SELECT MIN(price)
  FROM purchases
  WHERE character_name ="しお";
```
<br>

* 指定カラムごとにグループ化
```sql
  SELECT SUM(price),purchased_at
  FROM purchases
  GROUP BY purchased_at;　-- purchased_atごとの合計金額
```
<br>

* カラムの中でレコードを指定しグループ化
```sql
  SELECT SUM(price),purchased_at,character_name
  FROM purchases
  WHERE category="食費"    -- categoryが食費であるデータを購入日と購入者で金額を合計
  GROUP BY purchased_at,character_name;
```
<br>

* グループ化されたものから条件付きで検索  
```sql
  SELECT SUM(price),purchased_at
  FROM purchases
  GROUP BY purchased_at
  HAVING SUM(price) > 2000;    --検索はグループ化されたテーブルから
```
WHEREはグループ化される前のテーブル全体を検索対象とするのに対し、HAVINGはGROUP BYによってグループ化されたデータを検索対象とする
<br>

* 2つ以上のテーブルを紐づける
```sql
  SELECT players.name AS "選手名",teams.name AS "前年所属していたチーム"  --ASでカラム名変更
  FROM players
  JOIN teams
  ON teams.id = players.previous_team_id;  --idで紐づけ
```
カラムにnullがあるとデータは取ってこれない。nullも含める場合はJOIN →` LEFT JOIN `とする
<br>

* レコードを追加する
```sql
  例）データベース：studentsテーブル/ id, name, courseのカラム
  INSERT INTO students (name,course)
  VALUES ("Kate","Java");
```
<br>

* レコードを変更する
```sql
  UPDATE students
   SET name='Jordan', course='HTML'
   WHERE id=6;  --これがないと全部変更される！戻せないので忘れないように
```
<br>

* レコードを削除する
```sql
  DELETE FROM students
  WHERE id = 7;  --これがないと全部削除される！戻せないので忘れないように
```
<br>
