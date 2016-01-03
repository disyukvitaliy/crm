class ProjectsController < ActionController::Base

  layout "application"

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

end
