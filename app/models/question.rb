class Question < ActiveRecord::Base
  SEARCH_LIMIT = 10

  has_many :articles
  belongs_to :theme

  validates :theme, presence: true
  validates :content, presence: true

  def self.search(search)
    search = search.downcase
    where("LOWER(content) LIKE ?", "%#{search}%").limit(SEARCH_LIMIT)
  end
end
