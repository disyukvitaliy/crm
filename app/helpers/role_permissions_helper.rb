module RolePermissionsHelper

  # Update role permissions
  # @param model_object [Role] - role model
  # @param permission_ids [Array] - permissions ids
  # @return [Role] - role model
  def self.update(model_object, permission_ids)
    model_object.permissions.delete_all
    model_object.permissions = Permission.where(id: permission_ids).all
  end
end