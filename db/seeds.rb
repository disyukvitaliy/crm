# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
  Project.create do |p|
    p.title = "Project ##{i+1}"
    p.body = "Some description for this simple project ##{i+1}"
    p.alias = "project-#{i+1}"
  end
end

Project.find(2).update_attribute(:parent_id, 1)
Project.find(5).update_attribute(:parent_id, 3)

puts 'Projects: Several entries has been added.'
