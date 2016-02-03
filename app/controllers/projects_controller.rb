class ProjectsController < ApplicationController

  # we need next callbacks order: :set_project, :remember_project_id, parent :send_project_id_to_left_menu
  # also these callbacks must be triggered before parent :send_project_id_to_left_menu
  prepend_before_action :remember_project, only: [:show, :edit]
  prepend_before_action :forget_project, only: :index
  prepend_before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects_grid = ProjectsGrid.new(params[:projects_grid]) do |scope|
      scope.page(params[:page]).per(5)
    end
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        if @project.destroy
          render :js => "window.location = '#{request.referer}'"
        else
          render :alert, locals: {alert: @project.errors.full_messages.join('\n')}
        end
      end
      format.html do
        if @project.destroy
          redirect_to projects_path
        else
          render :edit
        end
      end
    end
  end

  private

  def set_project
    @project = Project.find_by_alias(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :alias, :descr, :parent_id)
  end

  def remember_project
    session[:project_param] = @project.to_param
    session[:project] = @project.serializable_hash
  end

  def forget_project
    session.delete(:project)
    session.delete(:project_param)
  end
end
