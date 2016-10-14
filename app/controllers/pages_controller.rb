class PagesController < ApplicationController
	def home
		@themes = Theme.all
	end

	def admin
	end
end
