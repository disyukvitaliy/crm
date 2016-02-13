class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!, :send_project_id_to_left_menu, :load_settings
  rescue_from Pundit::NotAuthorizedError, with: :have_no_access

  protected

  # @see Auth::SessionsController#new
  def authenticate_user!
    flash[:from_root_path] = true if request.path == root_path
    super
  end

  def send_project_id_to_left_menu
    @serialized_project = session[:project]
    @project_param = session[:project_param]
  end

  def load_settings
    @settings = Setting.first
  end

  def have_no_access
    render plain: 'You have no access to this page!', status: :unauthorized
  end
end
