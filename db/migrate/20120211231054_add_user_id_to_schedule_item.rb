class AddUserIdToScheduleItem < ActiveRecord::Migration
  def change
    add_column :schedule_items, :user_id, :integer
  end
end
