class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.title :string
      t.dex :integer

      t.timestamps
    end
  end
end
