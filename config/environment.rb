ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/nyc#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
