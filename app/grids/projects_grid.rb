class ProjectsGrid

  include Datagrid

  scope do
    Project
  end

  filter(:status, :enum, {select: Project.statuses, attr: {class: 'form-control input-sm'}})
  filter(:title, {attr: {class: 'form-control input-sm'}}) { |val| where("title ilike '%#{val}%'") }

  column(:id)
  column(:title, html: true) do |p|
    link_to p.title, project_path(p)
  end
  column(:descr)
  column(:status)
  column(:actions, html: true) do |p|
    link_to(:edit, edit_project_path(p)) + ' ' +
    link_to(:delete, project_path(p), method: :delete, data: { confirm: 'Are you sure?' })
  end

end
