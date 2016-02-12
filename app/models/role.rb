class Role < ActiveRecord::Base
  include UseBasePolicyConcern

  has_many :role_permissions
  has_many :permissions, through: :role_permissions

  validates_presence_of :name, :permissions
  validates_uniqueness_of :name
end
