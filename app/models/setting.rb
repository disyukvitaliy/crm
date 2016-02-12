class Setting < ActiveRecord::Base
  include UseBasePolicyConcern
  before_create :only_one_row

  private

  def only_one_row
    false if Setting.count > 0
  end

end
