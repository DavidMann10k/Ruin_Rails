class RemoveLastSeenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :last_seen
  end

  def down
    add_column :users, :last_seen, :datetime
  end
end
