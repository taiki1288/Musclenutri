class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sportingevent, :string
  end
end
