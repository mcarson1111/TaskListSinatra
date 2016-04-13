require 'sinatra'
require_relative 'lib/database'
require 'date'


class MyApp < Sinatra::Base

  get '/' do
    @task_list_database = TaskList::Task.new      #making a connection with the database
     erb :index
   end

   get '/new-task' do
     erb :new_task
  end

  post '/new-task' do
    @tasks = params["tasks"]
    @tasks["added_at"] = DateTime.now.to_s
    @task_list_database = TaskList::Task.new
    @task_list_database.insert!(@tasks)


  # rereoute?
    redirect '/'
  end

  post '/' do
    @task_list_database = TaskList::Task.new
    @is_completed = params["completed"]
    @is_completed[0] = DateTime.now.to_s
    @task_list_database.update_completion_time(@is_completed[0], @is_completed[1])

    erb :index
  end
run!

end
