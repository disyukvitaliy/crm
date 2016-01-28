class IssuesGrid

  include Datagrid

  scope do
    Issue
  end

  filter(:subj, {attr: {class: 'form-control input-sm'}}) { |val| where("subj ilike '%#{val}%'") }
  filter(:due_date, :date, {range: true,
    attr: {class: 'form-control input-sm container-fluide', 'data-provide' => 'datepicker', 'data-date-format' => 'yyyy-mm-dd'}})

  column(:id)
  column(:subj, html: true) do |i| link_to i.subj, issue_path(i) end
  column(:due_date)
  column(:actions, html: true) do |i|
    link_to(:edit, edit_issue_path(i)) + ' ' +
    link_to(:delete, issue_path(i), method: :delete, remote: true, data: { confirm: 'Are you sure?' })
  end

end
