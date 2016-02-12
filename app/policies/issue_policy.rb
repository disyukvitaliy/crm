class IssuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.accessed_issues
    end
  end
end
