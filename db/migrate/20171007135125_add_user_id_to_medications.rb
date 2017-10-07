class AddUserIdToMedications < ActiveRecord::Migration[5.1]
  def change
    add_column :medications, :user_id, :integer
  end
end
