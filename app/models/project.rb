class Project < ActiveRecord::Base

  # gem strip_attributes
  strip_attributes

  # gem awesome_nested_set
  acts_as_nested_set

  has_many :issues

  enum status: {archived: 0, active: 1}

  validates :title, uniqueness: true, presence: true
  validates :alias, uniqueness: true

  before_validation :transliterate_alias

  private
    def transliterate_alias
      self.alias = Translit.convert(self.title, :english) if self.alias.blank? & self.title?
    end
end
