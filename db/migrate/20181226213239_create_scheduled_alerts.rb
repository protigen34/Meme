class CreateScheduledAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :scheduled_alerts do |t|
      t.integer :delayed_job_id, :null => false, :unique => true
      t.references :medication_time, :null => false
      t.date :scheduled_date, :null => false
      t.timestamps
      t.index [ :medication_time_id, :scheduled_date ], :unique => true, :name => 'idx_uniq_med_time_date'
    end
  end
end
