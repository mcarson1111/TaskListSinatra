require 'sinatra'
require_relative 'lib/database'


class MyApp < Sinatra::Base

  get '/' do
    @task_list_database = TaskList::Task.new
     erb :index
   end






run!

end
