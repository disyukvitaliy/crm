class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :send_project_id_to_left_menu, :load_settings

  protected

  # @see Auth::SessionsController#new
  def authenticate_user!
    flash[:from_root_path] = true if request.path == root_path
    super
  end

  def send_project_id_to_left_menu
    @project_id = session[:project_id]
  end

  def load_settings
    @settings = Setting.first
  end

end
