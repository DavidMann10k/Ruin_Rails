class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.content :string
      t.topic_id :integer
      t.user_id :integer

      t.timestamps
    end
  end
end
