module UserProjectsHelper

  # Update user projects
  # @param model_object [User] - User model
  # @param project_ids [Array] - project ids
  # @return [User] - User model
  def self.update(model_object, project_ids)
    model_object.accessed_projects.delete_all
    model_object.accessed_projects = Project.where(id: project_ids).all
  end
end