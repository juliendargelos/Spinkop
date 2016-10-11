module ApplicationHelper
	ASSETS = __dir__ + '/../assets'
	STYLESHEETS = ASSETS + '/stylesheets'
	JAVASCRIPTS = ASSETS + '/javascripts'
	IMAGES = ASSETS + '/images'

	def title text
		content_for :title, text
	end

	def current_asset_name
		"#{controller_name}-#{action_name}"
	end

	def current_asset directory, type, &block
		asset = current_asset_name
		if File.file? "#{directory}/#{asset}.#{type}"
			return block.call asset
		end
	end

	def current_stylesheet type = 'sass'
		current_asset STYLESHEETS, type do |asset|
			stylesheet_link_tag asset, media: 'all', 'data-turbolinks-track' => true
		end
	end

	def current_javascript type = 'js'
		current_asset JAVASCRIPTS, type do |asset|
			javascript_include_tag asset, 'data-turbolinks-track' => true
		end
	end

	def defer_routes &block
		content_tag :script, type: 'text/javascript' do
			routes = block.call.html_safe
			concat 'routes = {'
			concat routes[0, routes.length - 1]
			concat '};'
		end
	end

	def defer route, path
		"#{route}:'#{path}',"
	end

	def get_svg file
		path = IMAGES + "/#{file}.svg"

		if File.file? path
			raw File.read path
		end
	end

	def rgb color, alpha = nil
		r = color[1..2].to_i(16).to_s(10)
		g = color[3..4].to_i(16).to_s(10)
		b = color[5..6].to_i(16).to_s(10)

		if alpha == nil
			"rgb(#{r},#{g},#{b})"
		else
			"rgba(#{r},#{g},#{b},#{alpha})"
		end
	end

	def theme_gradient color, from = 1, to = 0.6
		gradient = "linear-gradient(#{rgb color, to}, #{rgb color, from});"
		css = "background:#{gradient}"

		['webkit', 'moz', 'ms', 'o'].each do |vendor|
			css = "background:-#{vendor}-#{gradient}#{css}"
		end

		raw css
	end

	def model_select model, from, property = 'name', name = nil, default = nil, multiple = false
		options = model.all.map do |object|
			[object[property], object.id]
		end

		if name == nil
			name = model.name.camelize(:lower) + (multiple ? 's' : '_id')
		end

		if default == nil
			default = from[name]
		end

		options = options_for_select options, default

		name = from.class.name.camelize(:lower) + '['+name+']'

		if multiple
			name += '[]'
		end

		select_tag name, options
	end

	def theme_select from
		model_select Theme, from
	end

	# Will be removed
	def question_select from
		model_select Question, from, 'content'
	end
end
