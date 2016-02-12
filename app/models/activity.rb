class Activity < ActiveRecord::Base
  include EnumerableConcern
  include UseBasePolicyConcern
end
