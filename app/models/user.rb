class User < ActiveRecord::Base
  include UseBasePolicyConcern

  devise :database_authenticatable, :registerable, :rememberable, :validatable, :recoverable
  enum status: {active: true, inactive: false}

  belongs_to :role

  validates_presence_of :role_id

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    if inactive?
      :inactive
    else
      super # Use whatever other message
    end
  end
end
