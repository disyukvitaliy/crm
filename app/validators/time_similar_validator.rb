# @see String
class TimeSimilarValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'wrong format') unless TimeFormatService.new(value).right_format?
  end
end