class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.title :string
      t.dex :integer
      t.division_id :integer

      t.timestamps
    end
  end
end
