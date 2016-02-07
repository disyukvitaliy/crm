class TimeEntry < ActiveRecord::Base

  belongs_to :activity
  belongs_to :issue
  belongs_to :user

  validates_presence_of :issue_id, :activity_id, :date, :amount, :user_id, :issue_id
  validates :amount, time_similar: true, allow_blank: true
  validates :amount, time_zero: true, allow_blank: true

  before_save { write_attribute(:amount, TimeFormatService.new(amount).to_float.round(2)) }

  # we need to prevent type cast when assigning value to model
  def amount= value
    raw_write_attribute(:amount, value)
  end
end