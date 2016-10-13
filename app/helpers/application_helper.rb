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
			stylesheet_link_tag asset, media: 'all'
		end
	end

	def current_javascript type = 'js'
		current_asset JAVASCRIPTS, type do |asset|
			javascript_include_tag asset
		end
	end

	def short_date datetime
		month = [
			'Janv',
			'Fev',
			'Mar',
			'Avr',
			'Mai',
			'Juin',
			'Juillet',
			'Août',
			'Sep',
			'Oct',
			'Nov',
			'Dec'
		][datetime.strftime('%m').to_i-1]

		datetime.strftime('%d')+' '+month+' '+datetime.strftime('%Y')
	end

	def defer_routes &block
		content_tag :script, type: 'text/javascript' do
			concat 'routes = {'
			block.call
			concat '};'
		end
	end

	def defer name, route
		debug name.to_s
		if route[:js_params] != nil
			route[:js_params].each do |param|
				route[param] = "'+#{param}+'".html_safe
			end

			#route.delete :js_params

			concat "#{name}: function(#{route[:js_params].join ','}) {return '#{url_for route.except(:js_params)}';},".html_safe
		else
			concat "#{name}:'#{url_for route}',".html_safe
		end
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

	def theme_gradient theme, from = 1, to = 0.6
		color = theme.color
		gradient = "linear-gradient(#{rgb color, to}, #{rgb color, from});"
		css = "background:#{gradient}"

		['webkit', 'moz', 'ms', 'o'].each do |vendor|
			css = "background:-#{vendor}-#{gradient}#{css}"
		end

		raw css
	end

	def theme_picture theme, size = :medium
		raw "background-image: url('#{theme.picture.url(size)}');"
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
