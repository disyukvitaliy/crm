class ProjectsController < ApplicationController
  include CrudConcern

  append_before_action :remember_project, only: [:show, :edit]
  append_before_action :forget_project, only: [:index, :new]

  def create
    super { |project| project.update_attributes({user_id: current_user.id}) }
  end

  private

  def set_model_classes
    {model_class: Project, grid_model_class: ProjectsGrid}
  end

  def prepared_params
    super { [:title, :alias, :descr, :parent_id] }
  end

  # the working process is based on the projects.
  # we must choose some project to have ability like create issues,
  # view project's news or project wiki.
  # the left menu only appear when a project is selected
  def remember_project
    session[:project_param] = get_model_object.to_param
    session[:project] = get_model_object.serializable_hash
    send_project_id_to_left_menu
  end

  def forget_project
    session.delete(:project)
    session.delete(:project_param)
    send_project_id_to_left_menu
  end
end
