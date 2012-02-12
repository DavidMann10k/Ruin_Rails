class ChangeDayFromStringToIntegerInScheduleItems < ActiveRecord::Migration
  def change
    change_column :schedule_items, :day, :integer
  end
end
