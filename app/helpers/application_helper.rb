module ApplicationHelper
	def title text
		content_for :title, text
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
