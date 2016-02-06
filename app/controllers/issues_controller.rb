class IssuesController < ApplicationController
  include CrudConcern

  def all
    @issues_grid = IssuesGrid.new(params[:issues_grid]) do |scope|
      scope.page(params[:page]).per(5)
    end
    render :index
  end

  def index
    super { Project.find_by_alias(params[:project_id]).issues }
  end

  private

  def set_model_class
    @model_class = Issue
  end

  def set_grid_model_class
    @grid_model_class = IssuesGrid
  end

  def build_model_object(model_params)
    Project.find_by_alias(params[:project_id]).issues.new(model_params)
  end

  def prepared_params
    super { [:subj, :descr, :start_date, :due_date, :issue_priority_id, :issue_status_id, :estimated_time] }
  end
end
