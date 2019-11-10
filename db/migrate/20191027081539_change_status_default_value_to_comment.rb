class ChangeStatusDefaultValueToComment < ActiveRecord::Migration[5.2]
  def change
    change_column :comments,
                  :status,
                  :string,
                  null: false,
                  default: 'unapproved'
  end
end
