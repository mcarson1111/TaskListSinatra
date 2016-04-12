require 'sqlite3'

module TaskList
  class Database

  attr_reader :db

    def initialize(db_name = "to_do")
      @db = SQLite3::Database.new("database/#{db_name}.db")
    end

    def create_schema!
      query = <<-CREATESTATEMENT
        CREATE TABLE  task_list (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          descirption TEXT NOT NULL,
          added_at TEXT,
          completed_at TEXT
        );
      CREATESTATEMENT

      @db.execute("DROP TABLE IF EXISTS task_list;")
      @db.execute(query)
    end
  end
end
