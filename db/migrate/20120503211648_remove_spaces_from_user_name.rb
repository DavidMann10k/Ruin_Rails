class RemoveSpacesFromUserName < ActiveRecord::Migration
  def up
    User.all.each do |u|
      u.name = u.name.gsub(/ /, '_')
    end
  end
end
