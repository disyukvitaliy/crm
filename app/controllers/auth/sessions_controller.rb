class Auth::SessionsController < Devise::SessionsController
  layout 'authentication', only: :new

  # show alert flash message only after redirect from non root paths
  def new
    super do
      flash[:alert] = nil if flash[:from_root_path]
    end
  end
end
