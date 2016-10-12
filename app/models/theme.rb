class Theme < ActiveRecord::Base
    include HasSlug

    has_many :questions, dependent: :delete_all
    has_many :articles, through: :questions, dependent: :delete_all

    has_attached_file :picture, styles: { large: "1000x>", medium: "350x>", thumb: "80x80>" }
    validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

    validates :name, presence: true
    validates :color, presence: true, format: { with: /\A(?:#[abcdef0-9]{6})\z/i }
    validates :name, presence: true
    validates :picture, attachment_presence: true

    def someQuestions
        Question.some self
    end
end
