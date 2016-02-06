class TimeEntriesController < ApplicationController
  include CrudConcern

  def index
    super { |scope| scope.where(issue: params[:issue_id]) }
  end

  def new
    super { Issue.find(params[:issue_id]).time_entries.new }
  end

  private

  def set_model_class
    @model_class = TimeEntry
  end

  def set_grid_model_class
    @grid_model_class = TimeEntriesGrid
  end

  def prepared_params
    super { [:date, :issue_id, :activity_id, :amount, :comment] }
  end
end
