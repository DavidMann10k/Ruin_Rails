class AddLevelToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :level, :integer, :default => 0
  end
end
