class Admin::ActivitiesController < ApplicationController
  include CrudConcern
  include EnumerableControllerConcern

  before_action :set_model_object, only: [:edit, :update, :destroy, :set_default, :move_up, :move_down]

  private

  def set_model_class
    @model_class = Activity
  end

  def set_grid_model_class
    @grid_model_class = ActivitiesGrid
  end

  def prepared_params
    super { [:title, :priority, :status] }
  end
end
