class Admin::RolesController < ApplicationController
  include CrudConcern

  private

  def set_model_classes
    {model_class: Role, grid_model_class: RolesGrid}
  end

  def prepared_params
    super { [:name] }
  end

  def has_many_relations
    {permissions: RolePermissionsHelper}
  end
end
