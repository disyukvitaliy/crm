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

  def remember_project
    session[:project_param] = @model_object.to_param
    session[:project] = @model_object.serializable_hash
    send_project_id_to_left_menu
  end

  def forget_project
    session.delete(:project)
    session.delete(:project_param)
    send_project_id_to_left_menu
  end
end
