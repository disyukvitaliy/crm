class TimeEntry < ActiveRecord::Base

  belongs_to :activity
  belongs_to :issue

  validates_presence_of :issue_id, :activity_id, :date, :amount
  validates :amount, time_similar: true, allow_blank: true
  validates :amount, time_zero: true, allow_blank: true

  before_save { write_attribute(:amount, TimeFormatService.new(amount).to_minutes) }

  # we need to prevent type cast when assigning value to model
  def amount= value
    raw_write_attribute(:amount, value)
  end

  # @return [float] - amount sa float with 2 decimals
  def amount_as_float
    (amount.to_f / 60).round(2)
  end

end