class IssuesGrid

  include Datagrid
  extend GridHelper

  scope do
    Issue
  end

  filter(:subj)
  filter(:due_date)

  column(:id)
  column(:subj, html: true) do |i|
    link_to i.subj, issue_path(i)
  end
  column(:due_date)
  column(:actions, html: true) do |i|
    link_to(:edit, edit_issue_path(i)) + ' ' +
    link_to(:delete, issue_path(i), method: :delete, data: { confirm: 'Are you sure?' })
  end

end
