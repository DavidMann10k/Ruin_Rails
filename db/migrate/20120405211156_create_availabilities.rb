class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :day
      t.time :begin
      t.time :end
      t.integer :user_id

      t.timestamps
    end
  end
end
