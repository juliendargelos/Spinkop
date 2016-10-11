class Article < ActiveRecord::Base
  belongs_to :question

  validates :question, presence: true
  validates :content, presence: true

  before_save :clean_tags

  def clean_tags
    self.tags = self.tags.downcase
    self.tags = self.tags.gsub /[^a-z0-9,]/, ''
    self.tags = self.tags.gsub ',', ', '
  end
end
