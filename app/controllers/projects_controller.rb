class ProjectsController < ApplicationController
  include CrudConcern

  append_before_action :remember_project, only: [:show, :edit]
  append_before_action :forget_project, only: [:index, :new]

  private

  def set_model_class
    @model_class = Project
  end

  def set_grid_model_class
    @grid_model_class = ProjectsGrid
  end

  def set_model_object
    @model_object = @model_class.find_by_alias(params[:id])
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
