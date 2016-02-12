class Permission < ActiveRecord::Base
  include UseBasePolicyConcern

  has_many :role_permissions
  has_many :roles, through: :role_permissions

  default_scope { order(:section, :action) }
end
