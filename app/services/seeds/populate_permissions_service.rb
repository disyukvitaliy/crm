class Seeds::PopulatePermissionsService
  def call
    Rails.application.eager_load!
    Permission.delete_all
    ActiveRecord::Base.descendants.each do |model|
      actions.each do |action|
        Permission.create({section: model.name, action: action})
      end
    end

    Permission.create(section: 'Admin', action: 'administrate')
  end

  def actions
    [:index, :show, :create, :update, :destroy]
  end
end
