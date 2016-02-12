class Admin::ActivitiesController < ApplicationController
  include AdminControllerConcern
  include CrudConcern
  include EnumerableControllerConcern

  private

  def set_model_classes
    {model_class: Activity, grid_model_class: ActivitiesGrid}
  end

  def prepared_params
    super { [:title, :priority, :status] }
  end
end
