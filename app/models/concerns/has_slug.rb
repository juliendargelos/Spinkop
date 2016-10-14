module HasSlug extend ActiveSupport::Concern
	DEFAULT_PROPERTY = 'name'

	included do
    	before_save :update_slug
  	end

	def update_slug
		property = self.class.slug_property
		property = property == nil ? DEFAULT_PROPERTY : self.class.slug_property[:property].to_s

		self.slug = self[:"#{property}"]
		self.slug = self.slug.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '')
		self.slug = self.slug.downcase
		self.slug = self.slug.gsub(/[^A-Za-z0-9]/, '-')
		self.slug = self.slug.gsub(/\-\-+/, '-')
		self.slug = self.slug.gsub(/\A-/, '').gsub(/-\z/, '')
	end

    module ClassMethods
		attr_reader :slug_property

		private

		def slug property
			@slug_property = property
		end
    end
end
