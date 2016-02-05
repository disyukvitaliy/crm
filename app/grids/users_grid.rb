class UsersGrid

  include Datagrid

  scope do
    User
  end

  filter(:email, {attr: {class: 'form-control input-sm'}}) { |val| where("email ilike '%#{val}%'") }
  filter(:status, :enum, {select: User.statuses, attr: {class: 'form-control input-sm'}})

  column(:id)
  column(:email, html: true) { |u| link_to u.email, user_path(u) }
  column(:status)
  column(:actions, html: true) do |u|
    link_to(:edit, edit_user_path(u)) + ' ' +
    link_to(:delete, user_path(u), method: :delete, remote: true, data: { confirm: 'Are you sure?' })
  end

end
