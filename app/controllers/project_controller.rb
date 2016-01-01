class ProjectController < ActionController::Base

  layout "application"

  def index
    @projects = Project.all
  end

end
