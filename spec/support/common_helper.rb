module CommonHelper

  def admin_user
    User.first
  end

  alias :as_admin_user :admin_user
end
