class ProjectsController < ApplicationController
  #We need next callbacks order: :set_project, :remember_project_id, parent :send_project_id_to_left_menu
  prepend_before_action :remember_project_id, :only => [:show, :edit]
  prepend_before_action :forget_project_id, :only => :index
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
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :alias, :descr, :parent_id)
    end

    def remember_project_id
      session[:project_id] = @project.id
    end

    def forget_project_id
      session.delete(:project_id)
    end
end
