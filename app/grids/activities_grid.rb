class ActivitiesGrid

  include Datagrid

  scope do
    Admin::Activity
  end

  column(:id)
  column(:title)
  column(:priority)
  column(:status)
  column(:order, html: true) do |a|
    link_to(:up, order_up_admin_activity_path(a), method: :put) + ' ' +
    link_to(:down, order_down_admin_activity_path(a), method: :put)
  end
  column(:actions, html: true) do |a|
    link_to(:edit, edit_admin_activity_path(a)) + ' ' +
    link_to(:delete, admin_activity_path(a), method: :delete, data: { confirm: 'Are you sure?' })
  end

end
