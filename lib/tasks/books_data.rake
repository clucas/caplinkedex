namespace :app do
  desc "Import items CSV"
  task :import_csv => :environment do
    file = File.join( Rails.root.to_s, 'db', "import", "books.csv")
    Book.import_csv(file)
  end

  desc "Index data for search"
  task :index_search => :environment do
    Book.reindex
  end

  desc "Import data and re-ndex"
  task :import_and_index => [:import_csv, :index_search] do
  end
end
