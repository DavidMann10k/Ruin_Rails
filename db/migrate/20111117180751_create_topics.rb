class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.title :string
      t.forum_id :integer
      t.user_id :integer

      t.timestamps
    end
  end
end
