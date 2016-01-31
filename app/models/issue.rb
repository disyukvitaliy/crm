# TODO refactor common functionality (TimeEntry)
class Issue < ActiveRecord::Base

  belongs_to :project
  belongs_to :issue_priority
  belongs_to :issue_status
  has_many :time_entries

  validates_presence_of :subj, :descr, :estimated_time

  validate :check_estimated_time_format, unless: Proc.new { |i| i.estimated_time.blank? }

  before_save :save_estimated_time_as_minutes

  # we need to prevent type cast when assigning value to model
  def estimated_time= value
    raw_write_attribute(:estimated_time, value)
  end

  def save_estimated_time_as_minutes
    write_attribute(:estimated_time, TimeFormatService.new(estimated_time).to_minutes)
  end

  def estimated_time_as_float
    (estimated_time.to_f / 60).round(2)
  end

  def spent_time_as_float
    (self.time_entries.sum(:amount).to_f / 60).round(2)
  end

  def check_estimated_time_format
    tfs = TimeFormatService.new(estimated_time)
    if not tfs.right_format?
      errors.add(:estimated_time, 'wrong format')
    else
      errors.add(:estimated_time, 'can not be a zero') if tfs.zero?
    end
  end

end
