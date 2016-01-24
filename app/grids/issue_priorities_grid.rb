class IssuePrioritiesGrid

  include Datagrid

  scope do
    Admin::IssuePriority
  end

  column(:id)
  column(:title)
  column(:priority)
  column(:status)
  column(:order, html: true) do |i|
    link_to(:up, order_up_admin_activity_path(i), method: :put) + ' ' +
    link_to(:down, order_down_admin_activity_path(i), method: :put)
  end
  column(:actions, html: true) do |i|
    link_to(:edit, edit_admin_issue_priority_path(i)) + ' ' +
    link_to(:delete, admin_issue_priority_path(i), method: :delete, data: { confirm: 'Are you sure?' })
  end

end
