class ChangeContentToTextInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :content, :text, :limit => nil
  end
end
