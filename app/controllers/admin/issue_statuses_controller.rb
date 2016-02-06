class Admin::IssueStatusesController < ApplicationController
  include CrudConcern
  include EnumerableControllerConcern

  before_action :set_model_object, only: [:edit, :update, :destroy, :set_default, :set_closing, :move_up, :move_down]

  def set_closing
    IssueStatus.find(params[:id]).as_closing!
    redirect_to request.referer
  end

  private

  def set_model_class
    @model_class = IssueStatus
  end

  def set_grid_model_class
    @grid_model_class = IssueStatusesGrid
  end

  def prepared_params
    super { [:title, :priority, :status, :issue_status] }
  end
end
