class Admin::IssueStatusesController < ApplicationController
  include CrudConcern
  include EnumerableControllerConcern

  before_action :set_issue_status, only: :set_closing

  def set_closing
    IssueStatus.find(params[:id]).as_closing!
    redirect_to request.referer
  end

  private

  def set_model_classes
    {model_class: IssueStatus, grid_model_class: IssueStatusesGrid}
  end

  def prepared_params
    super { [:title, :priority, :status, :issue_status] }
  end

  def set_issue_status
    set_model_object
  end
end
