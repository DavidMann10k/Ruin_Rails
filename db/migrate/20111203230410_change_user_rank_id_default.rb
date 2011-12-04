class ChangeUserRankIdDefault < ActiveRecord::Migration
  def change
    change_column_default(:users, :rank_id, 1)
  end
end
