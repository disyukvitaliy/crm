class Seeds::PopulateRolesService
  def call
    Role.find_or_create_by({name: 'Admin'}) do |role|
      Permission.all.each do |permission|
        role.permissions << permission
      end
    end
  end
end
