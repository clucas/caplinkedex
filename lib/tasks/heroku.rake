namespace :heroku do
  desc 'deploy to Heroku'
  task :deploy do
    system "docker-compose build"
    system "heroku container:push web"
    system "heroku container:release web"
    system "heroku open"
  end
end
