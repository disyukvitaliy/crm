class Admin::UsersController < ApplicationController
  include CrudConcern

  def update
    super do |model_object|
      UserHelper.update_passwords model_object
    end
  end

  private

  def set_model_class
    @model_class = User
  end

  def set_grid_model_class
    @grid_model_class = UsersGrid
  end

  def prepared_params
    super { [:email, :password, :password_confirmation, :status] }
  end
end
