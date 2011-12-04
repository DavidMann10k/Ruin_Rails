class AddClearanceToRank < ActiveRecord::Migration
  def change
    add_column :ranks, :clearance, :integer, :default => 0
  end
end
