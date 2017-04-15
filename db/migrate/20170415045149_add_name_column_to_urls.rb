class AddNameColumnToUrls < ActiveRecord::Migration[5.0]
  def change
    add_column :urls, :name, :string
  end
end
