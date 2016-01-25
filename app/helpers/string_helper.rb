module StringHelper

  # is string numeric
  def self.is_n?(string)
    string =~ /\A\d+\z/ ? true : false
  end

end