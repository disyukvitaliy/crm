class Seeds::PopulatePermissionsService
  def call
    Rails.application.eager_load!
    Permission.delete_all
    sections.each do |section|
      actions.each do |action|
        Permission.create({section: section.name, action: action})
      end
    end

    Permission.create(section: 'Admin', action: 'administrate')
  end

  def sections
    ActiveRecord::Base.descendants.reject { |section| section.name == 'ActiveRecord::SchemaMigration' }
  end

  def actions
    [:index, :show, :create, :update, :destroy]
  end
end
