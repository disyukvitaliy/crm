class Seeds::PopulatePermissionsService
  def call
    Rails.application.eager_load!
    Permission.delete_all
    ActiveRecord::Base.descendants.each do |model|
      actions.each do |action|
        Permission.create({model: model.name, action: action})
      end
    end
  end

  def actions
    [:index, :show, :create, :update, :delete]
  end
end
