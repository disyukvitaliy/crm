class TimeFormatService

  def initialize value
    @value = value
  end

  def time?
    /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))?$/.match("#{@value}") # from 00:00 to 23:59
  end

  def float?
    /^(([0-9])|([0-1][0-9])|([2][0-3]))\.(([0-9])|([0-9][0-9]))?$/.match("#{@value}") # from 00.00 to 23.99
  end

  def int?
    /^(([0-9])|([0-1][0-9])|([2][0-4]))?$/.match("#{@value}") # from 0 to 24
  end

  def calculate_time
    h, m = @value.split(':')
    h.to_i * 60 + m.to_i
  end

  def calculate_float
    @value.to_f * 60
  end

  def calculate_int
    @value.to_i * 60
  end

  def to_minutes
    (calculate_time if time?) || (calculate_float if float?) || (calculate_int if int?) || 0
  end

  def right_format?
    [time?, float?, int?].any? ? true : false
  end

  def zero?
    to_minutes == 0
  end
end