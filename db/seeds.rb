
Seeds::PopulatePermissionsService.new.call
puts 'permissions table has been populated'
Seeds::PopulateRolesService.new.call
puts 'roles table has been populated'
user = Seeds::CreateAdminService.new.call
puts "users table has been populated with default entry, email: '#{user.email}' and password '#{user.password}'"
Seeds::CreateSettingsService.new.call
puts 'settings table has been populated with default entry'
Seeds::PopulateIssueStatusesService.new.call
puts 'issue_statuses table has been populated'
Seeds::PopulateIssuePrioritiesService.new.call
puts 'issue_priorities table has been populated'
Seeds::PopulateActivitiesService.new.call
puts 'activities table has been populated'
Seeds::PopulateProjectsService.new.call
puts 'projects table has been populated'
Seeds::PopulateIssuesService.new.call
puts 'issues table has been populated'