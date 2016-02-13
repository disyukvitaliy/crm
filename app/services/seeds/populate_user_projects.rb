class Seeds::PopulateUserProjects
  def call
    User.first.accessed_projects = Project.all
  end
end
