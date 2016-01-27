module EnumeratorBase

  # TODO refactor this. I think there is a better approach to share common functionality
  # I have encountered with setter methods
  # I could not specify its as just an instance method like as_default!
  def self.included base

    base.class_eval do

      enum status: {active: 1, disabled: 0}
      enum priority: {default: 1, common: 0}

      # gem acts_as_orderable
      acts_as_orderable position: :last

      validates :title, uniqueness: true, presence: true
      validates_uniqueness_of :priority, :if => :default?

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
  end

  # unmark previous default, and mark current
  def as_default!
    self.class.default.all.update_all(priority: self.class.priorities[:common])
    self.default!
  end
end
