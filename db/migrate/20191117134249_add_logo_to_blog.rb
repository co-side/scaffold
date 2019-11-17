class AddLogoToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :logo, :string
  end
end
