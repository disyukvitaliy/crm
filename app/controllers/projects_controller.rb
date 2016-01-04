class ProjectsController < ActionController::Base

  layout "application"

  def index
    @project_grid = initialize_grid(Project, order: 'projects.title', per_page: 5)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    Project.destroy(params[:id])
    redirect_to projects_path
  end

  private
    def project_params
      params.require(:project).permit(:title, :alias, :descr, :parent_id)
    end

end
