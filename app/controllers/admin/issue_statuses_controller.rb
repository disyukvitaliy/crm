class Admin::IssueStatusesController < Admin::CrudEnumeratorsController

  # TODO figure out how to inherit before_action only: [array]. We can write something like this:
  #
  # def self.set_model_only
  #   [:edit, :update, :destroy, :move_up, :move_down, :set_default]
  # end
  #
  # before_action :set_model_object, only: set_model_only
  #
  # There is possibility to override set_model_only in children [:new_action] + super
  # However it looks ugly, as self.set_model_only must be placed before filters
  def set_closing
    IssueStatus.find(params[:id]).as_closing!
    redirect_to action: 'index'
  end

  private

  def permitted_attributes
    [:issue_status] + super
  end

  def set_model_class
    @model_class = IssueStatus
  end

  def set_grid_model_class
    @grid_model_class = IssueStatusesGrid
  end
end
