class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    issues = Project.find(params[:project_id]).issues
    @issue_grid = initialize_grid(issues, order: 'issues.subj', per_page: 5)
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    @issue = Project.find(params[:project_id]).issues.new(issue_params)

    if @issue.save
      redirect_to @issue
    else
      render 'new'
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to @issue
    else
      render 'edit'
    end
  end

  def destroy
    @issue.destroy
    redirect_to project_issues_path(@issue.project_id)
  end

  private
    def set_issue
      @issue = Issue.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(:subj, :descr, :start_date, :due_date)
    end
end
