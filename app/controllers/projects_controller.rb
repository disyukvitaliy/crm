class ProjectsController < ActionController::Base

  layout "application"

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to action: "index"
    else
      render 'new'
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
