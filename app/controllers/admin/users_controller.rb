class Admin::UsersController < ApplicationController
  include AdminControllerConcern
  include CrudConcern

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end
    super
  end

  private

  def set_model_classes
    {model_class: User, grid_model_class: UsersGrid}
  end

  def prepared_params
    super { [:email, :password, :password_confirmation, :status, :role_id, {accessed_projects: []}] }
  end
end
