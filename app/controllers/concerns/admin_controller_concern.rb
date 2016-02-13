module AdminControllerConcern
  extend ActiveSupport::Concern

  included do
    before_action { authorize :Admin, :administrate? }
  end
end