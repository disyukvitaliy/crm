class Project < ActiveRecord::Base

  # gem awesome_nested_set
  acts_as_nested_set

  validates :title, uniqueness: true, presence: true
  validates :alias, uniqueness: true

  before_validation :transliterate_alias

  private
    def transliterate_alias
      self.alias = Translit.convert(self.title, :english) if self.alias.blank? & self.title?
    end
end
