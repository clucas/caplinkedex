json.extract! book, :id, :title, :author, :publisher, :published_on, :unit_cost, :category, :currency, :created_at, :updated_at
json.url book_url(book, format: :json)
