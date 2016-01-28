class Issue < ActiveRecord::Base

  belongs_to :project
  belongs_to :issue_priorities
  belongs_to :issue_statuses

  validates :subj, presence: true
  validates :descr, presence: true

end
