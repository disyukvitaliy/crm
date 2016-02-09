module RolePermissionsHelper

  # Update role permissions
  # @param model_object [Role] - role model
  # @param permission_ids [Array] - permissions ids
  # @return [Role] - role model
  def self.update(model_object, permission_ids)
    model_object.permissions.delete_all
    permission_ids.each { |permission_id| model_object.permissions << Permission.find(permission_id) }
    model_object
  end
end