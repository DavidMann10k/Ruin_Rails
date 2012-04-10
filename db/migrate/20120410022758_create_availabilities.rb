class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :user_id
      t.datetime :begin
      t.datetime :end
      t.boolean :un

      t.timestamps
    end
  end
end
