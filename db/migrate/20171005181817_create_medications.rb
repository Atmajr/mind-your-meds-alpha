class CreateMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :nickname
      t.string :condition
      t.string :doctor
      t.date :prescribed
      t.date :added
      t.integer :dosage
      t.string :dosage_units
      t.string :frequency
    end
  end
end
