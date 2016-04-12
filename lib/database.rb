require 'sqlite3'

module TaskList
  class Database

  attr_accessor :db

    def initialize(db_name = "to_do")
      @db = SQLite3::Database.new("database/#{db_name}.db")
    end

    def create_schema!
      query = <<-CREATESTATEMENT
        CREATE TABLE  task_list (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT,
          added_at TEXT,
          completed_at TEXT
        );
      CREATESTATEMENT

      db.execute("DROP TABLE IF EXISTS task_list;")
      db.execute(query)
    end
  end


  class Task < Database
 # inherits all methods from Database including initialize and attr for db

    def insert!(params_from_sinatra)

      insert_statement = <<-INSERTSTATEMENT
        INSERT INTO task_list (
          title, description, added_at, completed_at
        ) VALUES (
          :title, :description, :added_at, :completed_at
          );
      INSERTSTATEMENT

      prepared_statement = db.prepare(insert_statement)
      prepared_statement.execute(params_from_sinatra)

    end

    def all_tasks
      query = <<-QUERY
        SELECT title
        FROM task_list;
      QUERY

      all_tasks = db.execute(query)

    end

  end

end

# new_task = TaskList::Task.new
#
# new_task.insert!({"title" => "Clean house", "description"=> "Clean the house" , "added_at"=> "2016", "completed_at"=> ""})
