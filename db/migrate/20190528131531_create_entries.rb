# Entriesテーブルを作成するクラス
# 継承するクラス名の末尾の数値はこのファイルを生成したRailsのバージョン
class CreateEntries < ActiveRecord::Migration[5.2]
  # bin/rake db:migrateコマンドを実行したときの処理
  # entiresテーブルを作成し、string型のtitleカラムとtext型のbodyカラムを作成する
  # t.timestampsでcreated_atカラム（レコードの作成日時）とupdated_atカラム（レコードの更新日時）を作成する
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
