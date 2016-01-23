class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :send_project_id_to_left_menu, :only => [:show, :edit]

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

    def send_project_id_to_left_menu
      LeftMenu.instance.project_id @project.id
    end

end
