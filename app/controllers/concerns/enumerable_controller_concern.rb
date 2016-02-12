# TODO make it independent from CrudConcern
module EnumerableControllerConcern
  extend ActiveSupport::Concern

  included { before_action :set_enum_object, only: [:set_default, :move_up, :move_down] }

  def set_default
    get_model_object.as_default!
    redirect_to request.referer
  end

  def move_up
    get_model_object.move_up
    redirect_to request.referer
  end

  def move_down
    get_model_object.move_down
    redirect_to request.referer
  end

  private

  def set_enum_object
    set_model_object
  end
end