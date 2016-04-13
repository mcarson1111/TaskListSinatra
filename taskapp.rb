require 'sinatra'
require_relative 'lib/database'
require 'date' #for DateTime.now


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
    #override added_at key with whatever the timestamp is.  This prevents smarty pants people from messing with it in the developer tools online, too!
    @tasks["added_at"] = DateTime.now.to_s

    @task_list_database = TaskList::Task.new
    @task_list_database.insert!(@tasks)

    redirect '/'
  end

  post '/' do
    @task_list_database = TaskList::Task.new
    # when we bring in delete option, will need to asses if completed key exists?
    @is_completed = params["completed"]
    # Add the date/time as part of the post method in taskapp.rb.  Compelted button selected in index.erb
    @is_completed << DateTime.now.to_s
    @task_list_database.update_completion_time(@is_completed[0], @is_completed[1])

    erb :index
  end

  run!

end
