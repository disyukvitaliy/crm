class Admin::IssuePrioritiesController < ApplicationController
  include CrudConcern
  include EnumerableControllerConcern

  private

  def set_model_classes
    {model_class: IssuePriority, grid_model_class: IssuePrioritiesGrid}
  end

  def prepared_params
    super { [:title, :priority, :status] }
  end
end
