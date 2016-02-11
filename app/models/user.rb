class User < ActiveRecord::Base
  include UseBasePolicyConcern

  devise :database_authenticatable, :registerable, :rememberable, :validatable, :recoverable
  enum status: {active: true, inactive: false}

  belongs_to :role
  has_many :created_projects, class_name: 'Project', foreign_key: 'user_id'
  has_many :user_projects
  has_many :accessed_projects, through: :user_projects, source: 'project'

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
