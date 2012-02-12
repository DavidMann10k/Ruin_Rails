class ChangeEndHourToHoursAvailable < ActiveRecord::Migration
  def change
    rename_column :schedule_items, :end_hour, :duration
  end
end
