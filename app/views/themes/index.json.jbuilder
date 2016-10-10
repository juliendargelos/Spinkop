json.array!(@themes) do |theme|
  json.extract! theme, :id, :name, :picture, :color
  json.url theme_url(theme, format: :json)
end
