# Enumerable class has already reserved
module EnumerableConcern
  extend ActiveSupport::Concern

  included do
    enum status: {active: 1, disabled: 0}
    enum priority: {default: 1, common: 0}

    # gem acts_as_orderable
    acts_as_orderable position: :last

    validates :title, uniqueness: true, presence: true
    validates_uniqueness_of :priority, if: :default?
  end

  # unmark previous default, and mark current
  def as_default!
    self.class.default.all.update_all(priority: self.class.priorities[:common])
    self.default!
    self
  end
end