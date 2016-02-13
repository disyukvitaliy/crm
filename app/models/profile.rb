class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :ava, styles: { medium: '150x150#', thumb: '50x50#' }, default_url: '/images/ava/:style/ava.jpeg'
  validates_attachment_content_type :ava, content_type: /\Aimage\/.*\Z/

  # @param user User
  # @return Profile
  def self.create_for(user)
    self.create(user: user)
  end

  # @return String - email if no neither first_name nor second_name
  def name
    full_name.blank? ? user.email : full_name
  end

  # @return String - concatenated first_name and second_name
  def full_name
    [first_name, second_name].join(' ')
  end
end
