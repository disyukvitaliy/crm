class Seeds::PopulateRolesService
  def call
    Role.find_or_create_by({name: 'Admin'})
  end
end
