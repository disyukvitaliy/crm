class Issue < ActiveRecord::Base

  belongs_to :project
  belongs_to :issue_priority
  belongs_to :issue_status
  has_many :time_entries

  validates_presence_of :subj, :descr, :estimated_time
  validates :estimated_time, time_similar: true, time_zero: true, allow_blank: true

  before_save { write_attribute(:estimated_time, TimeFormatService.new(estimated_time).to_minutes) }

  # we need to prevent type cast when assigning value to model
  def estimated_time= value
    raw_write_attribute(:estimated_time, value)
  end

  def estimated_time_as_float
    (estimated_time.to_f / 60).round(2)
  end

  def spent_time_as_float
    (self.time_entries.sum(:amount).to_f / 60).round(2)
  end

end
