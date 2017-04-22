class AddImageColumnToUrls < ActiveRecord::Migration[5.0]
  def change
    add_column :urls, :image, :string
  end
end
