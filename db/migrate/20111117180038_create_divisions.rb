class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :title
      t.integer :dex

      t.timestamps
    end
  end
end
