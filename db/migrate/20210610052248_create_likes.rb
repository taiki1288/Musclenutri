class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false
      t.references :post, null: false
      t.timestamps
    end
  end
end
