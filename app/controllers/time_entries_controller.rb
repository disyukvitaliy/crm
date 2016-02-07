class TimeEntriesController < ApplicationController
  include CrudConcern

  def index
    super { |scope| scope.where(issue: params[:issue_id]) }
  end

  def new
    super { Issue.find(params[:issue_id]).time_entries.new }
  end

  def create
    super { |time_entry| time_entry.update_attributes({user_id: current_user.id}) }
  end

  private

  def set_model_classes
    {model_class: TimeEntry, grid_model_class: TimeEntriesGrid}
  end

  def prepared_params
    super { [:date, :issue_id, :activity_id, :amount, :comment] }
  end

  def redirect_after_successful_html_destroy(time_entry)
    redirect_to issue_time_entries_path time_entry.issue
  end
end
