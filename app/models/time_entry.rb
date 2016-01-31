# TODO refactor common functionality (Issue)
class TimeEntry < ActiveRecord::Base
  belongs_to :activity
  belongs_to :issue

  validates_presence_of :issue_id, :activity_id, :date, :amount
  validate :check_amount_format, unless: Proc.new { |t| t.amount.blank? }

  before_save :save_amount_as_minutes

  # we need to prevent type cast when assigning value to model
  def amount= value
    raw_write_attribute(:amount, value)
  end

  def save_amount_as_minutes
    write_attribute(:amount, TimeFormatService.new(amount).to_minutes)
  end

  def amount_as_float
    (amount.to_f / 60).round(2)
  end

  def check_amount_format
    tfs = TimeFormatService.new(amount)
    if not tfs.right_format?
      errors.add(:amount, 'wrong format')
    else
      errors.add(:amount, 'can not be a zero') if tfs.zero?
    end
  end
end