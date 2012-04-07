class RemoveScheduleItems < ActiveRecord::Migration
  def change
    drop_table :schedule_items
  end
end
