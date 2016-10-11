class PagesController < ApplicationController
	def home
		@themes = Theme.all
	end
end
