class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.user_id :integer
      t.provider :string
      t.uid :string
      t.uname :string
      t.uname :string
      t.uemail :string

      t.timestamps
    end
  end
end
