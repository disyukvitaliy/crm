class Issue < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  belongs_to :issue_priority
  belongs_to :issue_status
  has_many :time_entries

  validates_presence_of :subj, :descr, :estimated_time, :user_id, :project_id
  validates :estimated_time, time_similar: true, time_zero: true, allow_blank: true

  before_save { write_attribute(:estimated_time, TimeFormatService.new(estimated_time).to_float.round(2)) }

  # we need to prevent type cast when assigning value to model
  def estimated_time= value
    raw_write_attribute(:estimated_time, value)
  end

  def spent_time_as_float
    self.time_entries.sum(:amount)
  end
end
