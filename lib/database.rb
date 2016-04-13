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
        SELECT *
        FROM task_list;
      QUERY

      all_tasks = db.execute(query)

    end

    def all_incomplete_tasks
      # before a task is complete, it does NOT have a time stamp.  So, look for taks where complete = ""

      query = <<-QUERY
        SELECT *
        FROM task_list
        WHERE completed_at = "";
      QUERY

      all_incomplete_tasks = db.execute(query)

    end

    def update_completion_time(task_id, completed_time)
      query = <<-QUERY
        UPDATE task_list
        SET completed_at = ?
        WHERE id = ?;
      QUERY

      db.execute(query, completed_time, task_id)

    end

  end

end
