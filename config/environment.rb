require 'bundler'
require 'faker'
require 'tty-prompt'
Bundler.require
require_all 'lib'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
