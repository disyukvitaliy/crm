class IssuePrioritiesGrid

  include Datagrid

  scope do
    IssuePriority.order(:element_order)
  end

  column(:id)
  column(:title)
  column(:priority)
  column(:status)
  column(:element_order, html: true) do |i|
    link_to(:up, move_up_issue_priority_path(i), method: :put) + ' ' +
    link_to(:down, move_down_issue_priority_path(i), method: :put)
  end
  column(:actions, html: true) do |i|
    link_to(:edit, edit_issue_priority_path(i)) + ' ' +
    link_to(:delete, issue_priority_path(i), method: :delete, data: { confirm: 'Are you sure?' }) + ' ' +
    link_to(:default, set_default_issue_priority_path(i), method: :put)
  end

end
