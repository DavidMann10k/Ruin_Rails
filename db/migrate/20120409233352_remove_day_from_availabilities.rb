class RemoveDayFromAvailabilities < ActiveRecord::Migration
  def change
    remove_column :availabilities, :day
  end
end
