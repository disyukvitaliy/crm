class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

  # def all
  #   @issues_grid = IssuesGrid.new(params[:issues_grid]) do |scope|
  #     scope.page(params[:page]).per(5)
  #   end
  #   render :index
  # end

  def index
    @time_entries_grid = TimeEntriesGrid.new(params[:time_entries_grid]) do
      Issue.find(params[:issue_id]).time_entries.page(params[:page]).per(5)
    end
  end

  def show
  end

  def new
    @issue = TimeEntry.new
  end

  def edit
  end

  def create
    @issue = Issue.find(params[:issue_id]).time_entries.new(issue_params)

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
  def set_time_entry
    @time_entry = TimeEntry.find(params[:id])
  end

  def time_entry_params
    params.require(:issue).permit(:subj, :descr, :start_date, :due_date, :issue_priority_id, :issue_status_id)
  end
end
