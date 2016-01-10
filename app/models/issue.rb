class Issue < ActiveRecord::Base

  belongs_to :project

  validates :subj, presence: true
  validates :descr, presence: true

end
