class AddUseridToUrls < ActiveRecord::Migration[5.0]
  def change
    add_column :urls, :user_id, :integer
  end
end
