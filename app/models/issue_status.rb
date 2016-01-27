class IssueStatus < ActiveRecord::Base

  include EnumeratorBase

  # wether it is closed status to the issue?
  enum issue_status: {closing: 1, opening: 0}

  validates_uniqueness_of :issue_status, if: :closing?

  # unmark previous closing, and mark current
  def as_closing!
    IssueStatus.closing.all.update_all(issue_status: IssueStatus.issue_statuses[:opening])
    self.closing!
  end

  # convert string from POST to integer
  def issue_status= value
    if StringHelper.is_n? value
      write_attribute :issue_status, value.to_i
    elsif self.class.issue_statuses.has_key? value
      write_attribute :issue_status, self.class.issue_statuses[value]
    end
  end

end
