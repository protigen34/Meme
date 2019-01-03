class CreateMedicationTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :medication_times do |t|
      t.belongs_to :medication, :index => true, :foreign_key => true, :null => false
      t.integer :day_of_week, :null => false, :default => 0
      t.integer :time_of_day, :null => false
      t.timestamps
    end
  end
end
