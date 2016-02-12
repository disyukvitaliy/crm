class Admin::UsersController < ApplicationController
  include CrudConcern

  def update
    super do |model_object|
      UserHelper.update_passwords model_object
    end
  end

  private

  def set_model_classes
    {model_class: User, grid_model_class: UsersGrid}
  end

  def prepared_params
    super { [:email, :password, :password_confirmation, :status, :role_id] }
  end

  def has_many_relations
    {accessed_projects: UserProjectsHelper}
  end
end
