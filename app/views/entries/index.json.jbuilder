# indexへjson形式でリクエストされた際のレスポンスを記述するファイル
# jbuilderというテンプレートエンジンを使用してjsonを生成している
# 以下の処理は配列（ActiveRecord::Relation）形式の@entriesを回して、値を配列形式で返している
# 配列を処理する際、個々の要素から取得する値は部分テンプレートの_entry.json.jbuilderファイルで指定している
json.array! @entries, partial: "entries/entry", as: :entry
