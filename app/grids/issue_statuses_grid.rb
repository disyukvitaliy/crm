class IssueStatusesGrid

  include Datagrid

  scope do
    IssueStatus.order(:element_order)
  end

  column(:id)
  column(:title)
  column(:priority)
  column(:status)
  column(:issue_status)
  column(:element_order, html: true) do |s|
    link_to(:up, move_up_issue_status_path(s), method: :put) + ' ' +
    link_to(:down, move_down_issue_status_path(s), method: :put)
  end
  column(:actions, html: true) do |s|
    link_to(:edit, edit_issue_status_path(s)) + ' ' +
    link_to(:delete, issue_status_path(s), method: :delete, data: { confirm: 'Are you sure?' }) + ' ' +
    link_to(:default, set_default_issue_status_path(s), method: :put) + ' ' +
    link_to(:closing, set_closing_issue_status_path(s), method: :put)
  end

end
