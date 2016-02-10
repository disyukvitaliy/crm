module UseBasePolicyConcern
  extend ActiveSupport::Concern

  def policy_class
    ApplicationPolicy
  end

  class_methods do
    def policy_class
      ApplicationPolicy
    end
  end
end