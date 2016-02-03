# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

11.times do |i|
  project = Project.create do |p|
    p.title = "Project ##{i+1}"
    p.descr = "Some description for this simple project ##{i+1}"
    p.alias = "project-#{i+1}"
  end

  project.issues.create do |is|
    is.subj = "Issue ##{i+1}"
    is.descr = "Some description for this simple issue ##{i+1}"
    is.start_date = i.day.from_now.strftime('%Y-%m-%d')
    is.due_date = i.day.from_now.strftime('%Y-%m-%d')
  end
end

Project.find(2).update_attribute(:parent_id, 1)
Project.find(5).update_attribute(:parent_id, 3)

puts 'Projects: Several entries has been added.'
puts 'Issues: Several entries has been added.'

CreateSettingsService.new.call
puts 'Setting: Default entry has been added.'

user = CreateAdminService.new.call
puts "User: Default entry with email: '#{user.email}' and password '#{user.password}' has been added."
