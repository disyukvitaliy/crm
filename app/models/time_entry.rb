class TimeEntry < ActiveRecord::Base
  belongs_to :activity
  belongs_to :issue

  validates_presence_of :issue_id, :activity_id, :date, :amount
  validate :check_amount_format

  before_save :amount_as_minutes

  # we need to prevent type cast when assigning value to model
  def amount= value
    raw_write_attribute(:amount, value)
  end

  def check_time
    /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))?$/.match("#{amount}") # from 00:00 to 23:59
  end

  def check_float
    /^(([0-9])|([0-1][0-9])|([2][0-3]))\.(([0-9])|([0-9][0-9]))?$/.match("#{amount}") # from 00.00 to 23.99
  end

  def check_int
    /^(([0-9])|([0-1][0-9])|([2][0-4]))?$/.match("#{amount}") # from 0 to 24
  end

  def calculate_time
    h, m = amount.split(':')
    h.to_i * 60 + m.to_i
  end

  def calculate_float
    amount.to_f * 60
  end

  def calculate_int
    amount.to_i * 60
  end

  def amount_as_minutes
    write_attribute(:amount, amount_to_minutes)
  end

  def amount_as_float
    (amount.to_f / 60).round(2)
  end

  def amount_to_minutes
    (calculate_time if check_time) || (calculate_float if check_float) || (calculate_int if check_int)
  end

  def check_amount_format
    if not [check_time, check_float, check_int].any?
      errors.add(:amount, 'wrong format')
    else
      errors.add(:amount, 'can not be a zero') if amount_to_minutes == 0
    end
  end
end