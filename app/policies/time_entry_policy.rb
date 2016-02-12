class TimeEntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.time_entries
    end
  end
end
