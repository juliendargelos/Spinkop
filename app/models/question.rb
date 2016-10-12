class Question < ActiveRecord::Base
    include HasSlug
    slug property: :content

    SEARCH_LIMIT = 5
    SOME_LIMIT = 10

    has_many :articles, dependent: :delete_all
    belongs_to :theme

    validates :theme, presence: true
    validates :content, presence: true

    def self.search search, theme_slug = nil
        search = search.downcase
        theme = Theme.find_by(slug: theme_slug)

        if theme == nil
            where("LOWER(content) LIKE ?", "%#{search}%").limit(SEARCH_LIMIT)
        else
            where("LOWER(content) LIKE ? AND theme_id = ?", "%#{search}%", theme.id).limit(SEARCH_LIMIT)
        end
    end

    def self.some theme
        where("theme_id = ?", theme.id).limit(SOME_LIMIT)
    end
end
