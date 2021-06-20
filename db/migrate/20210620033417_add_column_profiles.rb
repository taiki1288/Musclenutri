class AddColumnProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :sportingevent, :string
  end
end
