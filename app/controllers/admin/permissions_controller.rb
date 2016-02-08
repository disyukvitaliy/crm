class Admin::PermissionsController < ApplicationController
  include CrudConcern

  private

  def set_model_classes
    {model_class: Permission, grid_model_class: PermissionsGrid}
  end

  def prepared_params
    super { [:model, :action] }
  end
end
