class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  before_action :send_project_id_to_left_menu, :only => [:index, :show, :edit]

  def all
    @issues_grid = IssuesGrid.new(params[:issues_grid]) do |scope|
      scope.page(params[:page]).per(5)
    end
    render :index
  end

  def index
    @issues_grid = IssuesGrid.new(params[:issues_grid]) do
      Project.find_by_alias(params[:project_id]).issues.page(params[:page]).per(5)
    end
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    @issue = Project.find_by_alias(params[:project_id]).issues.new(issue_params)

    if @issue.save
      redirect_to @issue
    else
      render :new
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to @issue
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        if @issue.destroy
          render :js => "window.location = '#{request.referer}'"
        else
          render :alert, locals: {alert: @issue.errors.full_messages.join('\n')}
        end
      end
      format.html do
        if @issue.destroy
          redirect_to project_issues_path(@issue.project_id)
        else
          render :edit
        end
      end
    end
  end

  private
  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:subj, :descr, :start_date, :due_date, :issue_priority_id, :issue_status_id)
  end
end
