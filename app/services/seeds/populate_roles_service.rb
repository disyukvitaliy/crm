class Seeds::PopulateRolesService
  def call
    Role.find_or_create_by({name: 'Admin'}) do |role|
      role.permissions = Permission.all
    end
  end
end
