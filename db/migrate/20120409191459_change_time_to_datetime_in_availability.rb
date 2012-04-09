class ChangeTimeToDatetimeInAvailability < ActiveRecord::Migration
  def change
    change_column :availabilities, :begin, :datetime
    change_column :availabilities, :end, :datetime
  end
end
