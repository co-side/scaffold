# json形式でリクエストされた際のレスポンスを生成するファイル
# entryモデルがもつ値のうち、どの値をレスポンスとして返すかを指定している
json.extract! entry, :id, :title, :body, :created_at, :updated_at
json.url entry_url(entry, format: :json)
