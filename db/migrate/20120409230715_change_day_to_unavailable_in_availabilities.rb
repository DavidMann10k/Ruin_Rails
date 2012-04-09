class ChangeDayToUnavailableInAvailabilities < ActiveRecord::Migration
  def change
    change_column :availabilities, :day, :boolean
    rename_column :availabilities, :day, :unavailable
  end
end
