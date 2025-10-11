class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :slug
      t.integer :clicks

      t.timestamps
    end
    add_index :urls, :slug
  end
end
