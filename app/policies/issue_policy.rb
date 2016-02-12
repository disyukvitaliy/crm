class IssuePolicy < ApplicationPolicy

  # @return [Hash] - of permitted attributes
  def permitted_attributes
    [:subj, :descr, :start_date, :due_date, :issue_priority_id, :issue_status_id, :estimated_time]
  end

  # if current_user is not creator of the issue
  # he can not update some attributes
  # @return [Hash] - of permitted attributes
  def permitted_attributes_for_update
    return permitted_attributes if record.user_id == user.id
    permitted_attributes.reject do |attr|
      [:start_date, :due_date, :estimated_time].include? attr
    end
  end

  class Scope < Scope
    def resolve
      user.accessed_issues
    end
  end
end
