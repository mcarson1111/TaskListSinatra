require_relative 'database.rb'

TaskList::Database.new.create_schema!
