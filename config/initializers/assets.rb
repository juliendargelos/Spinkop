# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Les assets de chaque controlleur et action sont chargés séparement

Rails.application.eager_load!

ApplicationController.descendants.each do |controller|
	actions = controller.action_methods

	controller = controller.to_s
	controller = controller[0, controller.length - "controller".length].downcase

	actions.each do |action|
		name = "#{controller}-#{action}"
		Rails.application.config.assets.precompile += [
			"#{name}.css",
			"#{name}.js"
		]
	end
end
