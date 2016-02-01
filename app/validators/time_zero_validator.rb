# @see String
class TimeZeroValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'can not be a zero') if TimeFormatService.new(value).zero?
  end
end