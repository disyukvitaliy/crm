class Admin::IssuePrioritiesController < ApplicationController
  include CrudConcern
  include EnumerableControllerConcern

  before_action :set_model_object, only: [:edit, :update, :destroy, :set_default, :move_up, :move_down]

  private

  def set_model_classes
    {model_class: IssuePriority, grid_model_class: IssuePrioritiesGrid}
  end

  def prepared_params
    super { [:title, :priority, :status] }
  end
end
