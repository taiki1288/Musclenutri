class RemoveColumProfiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :sportingevent, :string
  end
end
