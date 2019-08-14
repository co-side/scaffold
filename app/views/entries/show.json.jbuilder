# showへjson形式でリクエストされた際のレスポンスを記述するファイル
# jbuilderというテンプレートエンジンを使用してjsonを生成している
# 部分テンプレートの_entry.json.jbuilderに@entryを渡している
# @entryのどのカラムをレスポンスとして返すかは_entry.json.jbuilderで処理している
json.partial! "entries/entry", entry: @entry
