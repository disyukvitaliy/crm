# Working with the strings which similar to the time
# @attr @value [String] description
class TimeFormatService

  # @param [String] value - string like 2:20 or 2.4 or 2
  def initialize value
    @value = value
  end


  # @return [Bool] - true if string is similar to time format (from 00:00 to 23:59)
  def time?
    /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))?$/.match("#{@value}")
  end

  # @return [Bool] - true if string is similar to float format (from 00.00 to 23.99)
  def float?
    /^(([0-9])|([0-1][0-9])|([2][0-3]))\.(([0-9])|([0-9][0-9]))?$/.match("#{@value}") # from 00.00 to 23.99
  end

  # @return [Bool] - true if string is similar to integer format (from 0 to 24)
  def int?
    /^(([0-9])|([0-1][0-9])|([2][0-4]))?$/.match("#{@value}") # from 0 to 24
  end

  # @return [Integer] - @value converted to minutes
  def calculate_time
    h, m = @value.split(':')
    h.to_f + m.to_f / 60
  end

  # @see #calculate_time
  def calculate_float
    @value.to_f
  end

  # @see #calculate_time
  def calculate_int
    @value.to_f
  end

  # @return [Float] - @value converted to float
  def to_float
    (calculate_time if time?) || (calculate_float if float?) || (calculate_int if int?) || nil
  end

  # @return [Bool] - true if @value similar to the time format
  def right_format?
    [time?, float?, int?].any? ? true : false
  end

  # @return [Bool] - true if @value is zero
  def zero?
    to_float == 0
  end
end