class IssuePrioritiesGrid

  include Datagrid

  scope do
    Admin::IssuePriority.order(:element_order)
  end

  column(:id)
  column(:title)
  column(:priority)
  column(:status)
  column(:element_order, html: true) do |i|
    link_to(:up, move_up_admin_activity_path(i), method: :put) + ' ' +
    link_to(:down, move_down_admin_activity_path(i), method: :put)
  end
  column(:actions, html: true) do |i|
    link_to(:edit, edit_admin_issue_priority_path(i)) + ' ' +
    link_to(:delete, admin_issue_priority_path(i), method: :delete, data: { confirm: 'Are you sure?' })
  end

end
