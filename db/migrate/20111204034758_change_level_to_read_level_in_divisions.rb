class ChangeLevelToReadLevelInDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :write_level, :integer, :default => 0
    rename_column :divisions, :level, :read_level
  end
end
