class Comment < ApplicationRecord
  belongs_to :entry

  # 承認された本文のみをviewで表示させるためのメソッド
  def approved_body
    status == 'approved' ? body : '（承認待ち）'
  end
end
