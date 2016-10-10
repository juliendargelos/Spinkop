json.array!(@articles) do |article|
  json.extract! article, :id, :content, :question_id
  json.url article_url(article, format: :json)
end
