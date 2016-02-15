class Seeds::CreateAdminService
  def call
    User.find_or_create_by!(email: 'admin@example.com') do |user|
      user.password = 'adminexample'
      user.password_confirmation = 'adminexample'
      user.status = User.statuses[:active]
      user.role_id = Role.first.id
    end
  end
end
