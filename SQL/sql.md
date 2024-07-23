# DML
* 特定の文字を含むデータを検索
```sql
  SELECT *
  FROM purchases
  WHERE name LIKE "%プリン%";  --前後に文字OK
```
<br>

* 含まない、一致しないデータを検索
```sql
  SELECT *
  FROM purchases
  WHERE NOT name LIKE "%プリン%";

  SELECT *
  FROM purchases
  WHERE NOT price > 1000;  --1000円以下のデータ
```
<br>

* 特定の範囲を含むデータを検索
```sql
  SELECT * 
  FROM users 
  WHERE age BETWEEN 21 AND 24;  --21～24歳の人
```
<br>

* 当てはまるデータを検索
```sql
  SELECT *
  FROM users
  WHERE prefecture IN ("東京都", "神奈川県");  --東京、神奈川の住所の人
```
<br>

* 当てはまらないデータを検索
```sql
  SELECT *
  FROM users
  WHERE prefecture NOT IN ("東京都", "神奈川県");  --東京、神奈川「以外」の住所の人
```
<br>

* 指定したデータが存在していた場合に目的のデータを検索
```sql
  SELECT * FROM users
  WHERE EXISTS
  (SELECT * FROM users
  WHERE age = 25);    -- 25歳の人が存在した場合にすべてのデータを検索
```
<br>

* 空欄のデータを検索
```sql
  SELECT *
  FROM purchases
  WHERE price IS NULL;
```
<br>

* 空欄でないデータを検索
```sql
  SELECT *
  FROM purchases
  WHERE price IS NOT NULL;
```
<br>

* 複数の条件を検索
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
カラムにnullがあるとデータは取ってこれない。nullも含める場合は` JOIN ` →` LEFT JOIN `とする  
<br>
省略して書くことも可能
```sql
  SELECT P.name AS "選手名",T.name AS "前年所属していたチーム"  --ASでplayer→P,team→Tに変更
  FROM players AS P  --このASも省略して player P　と書くこともできる
  JOIN teams AS T
  ON teams.id = players.previous_team_id;  --idで紐づけ
```
<br>

<br>

* レコードを追加する
```sql
  例）データベース：studentsテーブル/ id, name, courseのカラム
  INSERT INTO students (name,course)
  VALUES ("Kate","Java");
```
カラム名を書かない場合、VALUESにはカラムの数だけ値を指定する（数が合わないとエラーになる）
```sql
  例）データベース：studentsテーブル/ id, name, courseのカラム
  INSERT INTO students
  VALUES (3, "Kate", "Java");
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

* ビューにまとめる
```sql
  CREATE VIEW UsersInKanto(family_name, first_name, age, prefecture)  --CREATE VIEW ビュー名(カラム名1, カラム名2, ...)
  AS
  SELECT family_name, first_name, age, prefecture
  FROM users
  WHERE prefecture IN("東京都", "神奈川県", "埼玉県", "千葉県")
  ORDER BY prefecture;
```

使うとき

```sql
  SELECT *
  FROM UsersInKanto;
```
<br>

# DCL
* トランザクション全体の構文
* 例）BankAccountテーブル

| AccountNumber | Name | Balance |
|:---:|:---:|:---:|
| 1234567 | A | 50,000 |
| 7654321 | B | 50,000 |

```sql
  START TRANSACTION;  -- トランザクション開始文(MySQLの場合)
  
    UPDATE BankAccount SET Balance = Balance - 10000 
    WHERE AccountNumber = 1234567;    -- Aさんの口座から1万円をマイナス
  
    UPDATE BankAccount SET Balance = Balance + 10000 
    WHERE AccountNumber = 7654321;  　-- Bさんの口座に1万円をプラス
  
  COMMIT;　  -- トランザクション終了文。変更を確定して終了
　　--または
　ROLLBACK;  -- 変更を破棄して終了
```
