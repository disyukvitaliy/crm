class EnumeratorBase < ActiveRecord::Base
  self.abstract_class = true

  # gem acts_as_orderable
  acts_as_orderable position: :last

  enum status: {active: 1, disabled: 0}
  enum priority: {default: 1, common: 0}

  validates :title, uniqueness: true, presence: true
  validates_uniqueness_of :priority, :if => :default?

  # unmark previous default, and mark current
  def as_default!
    self.class.where('id != ?', self.id)
        .where(priority: self.class.priorities[:default])
        .update_all(priority: self.class.priorities[:common])

    self.default!
  end

  # convert string from POST to integer
  def priority= value
    if StringHelper.is_n? value
      write_attribute :priority, value.to_i
    elsif self.class.priorities.has_key? value
      write_attribute :priority, self.class.priorities[value]
    end
  end

  # convert string from POST to integer
  def status= value
    if StringHelper.is_n? value
      write_attribute :status, value.to_i
    elsif self.class.statuses.has_key? value
      write_attribute :status, self.class.statuses[value]
    end
  end
end
