class CreateSettingsService
  def call
    Setting.find_or_create_by!(site_name: 'CRM')
  end
end
