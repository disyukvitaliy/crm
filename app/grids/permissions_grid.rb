class PermissionsGrid

  include Datagrid

  scope do
    Permission
  end

  column(:id)
  column(:section)
  column(:action)
  column(:actions, html: true) do |p|
    link_to(:edit, edit_permission_path(p)) + ' ' +
    link_to(:delete, permission_path(p), method: :delete, remote: true, data: { confirm: 'Are you sure?' })
  end

end
