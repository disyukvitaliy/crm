class AdminPolicy < ApplicationPolicy
  def administrate?
    can? :administrate
  end
end
