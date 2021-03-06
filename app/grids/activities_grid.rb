class ActivitiesGrid

  include Datagrid

  scope do
    Activity.order(:element_order)
  end

  column(:id)
  column(:title)
  column(:priority)
  column(:status)
  column(:element_order, html: true) do |a|
    link_to(:up, move_up_activity_path(a), method: :put) + ' ' +
    link_to(:down, move_down_activity_path(a), method: :put)
  end
  column(:actions, html: true) do |a|
    link_to(:edit, edit_activity_path(a)) + ' ' +
    link_to(:delete, activity_path(a), method: :delete, remote: true, data: { confirm: 'Are you sure?' }) + ' ' +
    link_to(:default, set_default_activity_path(a), method: :put)
  end

end
