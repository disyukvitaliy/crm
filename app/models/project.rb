class Project < ActiveRecord::Base
  include FriendlyId

  # gem friendly_id
  friendly_id :title, use: [:slugged, :finders]

  # gem strip_attributes
  strip_attributes

  # gem awesome_nested_set
  acts_as_nested_set

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :accessed_users, through: :user_projects, source: 'user'
  has_many :user_projects
  has_many :issues, dependent: :restrict_with_error
  has_many :accessed_issues, class_name: 'Issue', foreign_key: 'project_id'

  enum status: {archived: 0, active: 1}

  with_options presence: :true do |assoc|
    assoc.validates :title, uniqueness: true
    assoc.validates :creator
  end
end
