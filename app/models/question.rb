class Question < ActiveRecord::Base
  has_many :articles
  belongs_to :theme

  validates :theme, presence: true
  validates :content, presence: true
end
