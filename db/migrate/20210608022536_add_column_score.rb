class AddColumnScore < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :score, :integer
  end
end
