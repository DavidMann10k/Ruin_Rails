class CreateScheduleItems < ActiveRecord::Migration
  def change
    create_table :schedule_items do |t|
      t.string :day
      t.integer :start_hour
      t.integer :end_hour

      t.timestamps
    end
  end
end
