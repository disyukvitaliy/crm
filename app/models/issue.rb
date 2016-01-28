class Issue < ActiveRecord::Base

  belongs_to :project
  belongs_to :issue_priority
  belongs_to :issue_status

  validates :subj, presence: true
  validates :descr, presence: true

end
