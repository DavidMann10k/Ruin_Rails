# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ranks = [{ :title => 'Registered', :clearance => 0 },{ :title => 'Guest', :clearance => 1 },{ :title => 'Member', :clearance => 2 }, { :title => 'Officer', :clearance => 3 }]

ranks.each do |r|
  rank = Rank.new
  rank.title = r[:title]
  rank.clearance = r[:clearance]
  rank.save
end
