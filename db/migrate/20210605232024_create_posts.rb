class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.text :content, null: false
      t.integer :price
      t.timestamps
    end
  end
end
