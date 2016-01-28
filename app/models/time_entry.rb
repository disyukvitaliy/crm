class TimeEntry < ActiveRecord::Base
  belongs_to :activity
  belongs_to :issue
end
