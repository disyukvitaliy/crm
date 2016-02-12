class RolesGrid

  include Datagrid

  scope do
    Role
  end

  column(:id)
  column(:name)
  column(:actions, html: true) do |r|
    link_to(:edit, edit_role_path(r)) + ' ' +
    link_to(:delete, role_path(r), method: :delete, remote: true, data: { confirm: 'Are you sure?' })
  end

end
