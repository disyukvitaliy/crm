class Project < ActiveRecord::Base

  validates :title, uniqueness: true, presence: true
  validates :alias, uniqueness: true

  before_validation :transliterate_alias

  private
    def transliterate_alias
      self.alias = Translit.convert(self.title, :english) if self.alias.blank? & self.title?
    end

end
