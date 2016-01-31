class TimeEntriesGrid

  include Datagrid

  scope do
    TimeEntry.joins(:activity).joins(:issue).select('time_entries.*, issues.subj AS issue_subj, activities.title AS activity_title')
  end

  filter(:activity, :enum, {select: proc { Activity.all.map {|a| [a.title, a.id] }}, attr: {class: 'form-control input-sm'}})
  filter(:date, :date, {attr: {class: 'form-control input-sm container-fluide', 'data-provide' => 'datepicker', 'data-date-format' => 'yyyy-mm-dd'}})

  column(:id)
  column(:date)
  column(:activity_id) { |t| t.activity_title }
  column(:issue_id) { |t| t.issue_subj }
  column(:comment)
  column(:amount) {|t| t.amount_as_float}
  column(:actions, html: true) do |t|
    link_to(:edit, edit_time_entry_path(t)) + ' ' +
    link_to(:delete, time_entry_path(t), method: :delete, remote: true, data: { confirm: 'Are you sure?' })
  end

end
