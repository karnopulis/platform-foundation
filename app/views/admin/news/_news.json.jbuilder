json.extract! news, :id, :title, :brief, :text, :created_at, :updated_at
json.url news_url(news, format: :json)