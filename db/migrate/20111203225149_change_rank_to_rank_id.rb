class ChangeRankToRankId < ActiveRecord::Migration
  def change
    rename_column :users, :rank, :rank_id
  end
end
