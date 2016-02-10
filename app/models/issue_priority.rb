class IssuePriority < ActiveRecord::Base
  include EnumerableConcern
  include UseBasePolicyConcern
end
