class Project < ActiveRecord::Base
  include FriendlyId

  # gem friendly_id
  friendly_id :title, use: [:slugged, :finders]

  # gem strip_attributes
  strip_attributes

  # gem awesome_nested_set
  acts_as_nested_set

  belongs_to :user
  has_many :issues, dependent: :restrict_with_error

  enum status: {archived: 0, active: 1}

  with_options presence: :true do |assoc|
    assoc.validates :title, uniqueness: true
    assoc.validates :user_id
  end
end
