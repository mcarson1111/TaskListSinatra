require 'sinatra'
require_relative 'lib/database'
require 'date' #for DateTime.now


class MyApp < Sinatra::Base

  get '/' do
    @task_list_database = TaskList::Task.new

    erb :index
  end

  put '/' do
    @task_list_database = TaskList::Task.new

    erb :index
  end


  post '/' do
    @task_list_database = TaskList::Task.new
    # when we bring in delete option, will need to asses if completed key exists?
    @is_completed = params["completed"]
    @is_removed = params["removed"]
    # Add the date/time as part of the post method in taskapp.rb.  Compelted button selected in index.erb

    if !@is_completed.nil?
    #if the is completed array is not nil, we have the information to complete the task
    @is_completed << DateTime.now.to_s
    @task_list_database.update_completion_time(@is_completed[0], @is_completed[1])

    else # the user wants to remove the task
    # the only other option is the is removed array is not nil, and therefore we have the information to remove the task
    @task_list_database.remove_task(@is_removed[0], @is_removed[1])

    end

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


  run!

end
