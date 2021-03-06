require 'bundler'
Bundler.require

require 'active_record'

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each{ |f| require f }

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
