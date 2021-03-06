# モデルファイル
# テーブルごとに対応するモデルが作成される
# Railsはモデル層にActiveRecordを採用しており、各モデルはActiveRecordを継承して作られる
# ActiveRecordを使うことでSQLを意識せずにデータベースとのやり取りが可能となる

class Entry < ApplicationRecord
  extend Enumerize

  belongs_to :blog
  has_many :comments, dependent: :destroy

  enumerize :genre, in: [:entertainment, :sport, :music, :game]
  validates :title, presence: true
end
