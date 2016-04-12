require 'sinatra'
require_relative 'lib/database'


class MyApp < Sinatra::Base

  get '/' do
    @task_list_database = TaskList::Task.new
     erb :index
   end

   get '/new-task' do
     erb :new_task
  end

  post '/new-task' do
    @tasks = params["tasks"]
    @task_list_database = TaskList::Task.new
    @task_list_database.insert!(@tasks)


    erb :new_task
  end

run!

end
