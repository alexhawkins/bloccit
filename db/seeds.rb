# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

24.times do
  p = Post.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
  3.times do
    p.comments.create(body: Faker::Lorem.paragraph)
  end  
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
