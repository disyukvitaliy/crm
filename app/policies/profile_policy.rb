class ProfilePolicy < ApplicationPolicy
  private

  def record_in_scope?
    user.profile == record
  end
end
