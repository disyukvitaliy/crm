module AdminControllerConcern
  extend ActiveSupport::Concern

  included do
    before_action { authorize :Admin, :administrate? }
    rescue_from Pundit::NotAuthorizedError, with: :is_not_admin
  end

  protected

  def is_not_admin
    render plain: 'You have no access to this page!', status: :unauthorized
  end
end