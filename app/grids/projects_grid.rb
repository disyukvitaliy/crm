class ProjectsGrid

  include Datagrid
  extend GridHelper

  scope do
    Project
  end

  filter(:status, :enum, :select => {archived: 0, active: 1})
  filter(:title, :string) { |value| where("title ilike '%#{value}%'") }

  column(:id)
  column(:title) do |p|
    link_to p.title, project_path(p)
  end
  column(:descr)
  column(:status)
  column(:actions) do |p|
    link_to(:edit, edit_project_path(p)) + ' ' +
    link_to(:delete, project_path(p), method: :delete, data: { confirm: 'Are you sure?' })
  end

end
