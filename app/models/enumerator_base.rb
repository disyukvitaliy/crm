class EnumeratorBase < ActiveRecord::Base
  self.abstract_class = true

  enum status: {active: 1, disabled: 0}
  enum priority: {default: 1, common: 0}

  def priority= value
    write_attribute(:priority, value.to_i)
  end

  def status= value
    write_attribute(:status, value.to_i)
  end
end
