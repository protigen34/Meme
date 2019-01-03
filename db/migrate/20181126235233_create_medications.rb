class CreateMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :medications do |t|
      t.string :name, :null => false
      t.string :unit, :null => false
      t.integer :quantity, :null => false
      t.text :directions
      t.timestamps
      t.index [ :name, :unit, :quantity ], :unique => true
    end
  end
end
