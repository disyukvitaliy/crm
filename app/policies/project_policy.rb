class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.accessed_projects
    end
  end
end
