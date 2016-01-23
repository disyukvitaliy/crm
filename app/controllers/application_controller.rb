class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :send_project_id_to_left_menu

  protected
    def send_project_id_to_left_menu
      LeftMenu.instance.project_id = session[:project_id]
    end
end
