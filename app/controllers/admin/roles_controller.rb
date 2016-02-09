class Admin::RolesController < ApplicationController
  include CrudConcern

  def new
    super
    set_selected_permission_ids([])
  end

  def edit
    super
    set_selected_permission_ids(@model_object.permissions.pluck(:id))
  end

  def create
    super do |model_object|
      update_permissions model_object
    end
  end

  def update
    super do |model_object|
      update_permissions model_object
    end
  end

  private

  def set_model_classes
    {model_class: Role, grid_model_class: RolesGrid}
  end

  def prepared_params
    super { [:name] }
  end

  def update_permissions(model_object)
    permission_ids = params[:role][:permissions] || []
    RolePermissionsHelper.update(model_object, permission_ids).save
    set_selected_permission_ids(permission_ids)
  end

  def set_selected_permission_ids(permission_ids)
    @selected_permission_ids = permission_ids
  end
end
