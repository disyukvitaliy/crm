class IssueStatus < ActiveRecord::Base
  include EnumerableConcern
  include UseBasePolicyConcern

  # wether it is closed status to the issue?
  enum issue_status: {closing: 1, opening: 0}

  validates_uniqueness_of :issue_status, if: :closing?

  # unmark previous closing, and mark current
  # @return [self]
  def as_closing!
    IssueStatus.closing.all.update_all(issue_status: IssueStatus.issue_statuses[:opening])
    self.closing!
    self
  end

end
