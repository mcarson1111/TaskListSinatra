# Task List
We are going to use our new found knowledge of databases and web development to create a task list, powered by Sinatra and SQLite. This project will enable us to persist tasks for a to-do list by adding, listing, and optionally editing and deleting them.

## Baseline Setup
This is a pair project. You will work with an assigned pair to complete all project requirements. This project has the regular Git setup:

- Decide who will fork the repo.
- Fork the repo to one person's Github account, then add the other person as a _collaborator_ on the project.
- Both people should clone the project inside their `~/C5/projects` directory.

## Baseline Requirements
**Work together to accomplish this baseline:**

For the baseline you will need to create the following project files:

- A __Gemfile__ with all of the gems necessary for Sinatra, SQLite, and anything else you want to use (pry, rerun, etc).
- A Sinatra class for your routes, and a root route (`/`).
- An `index.erb` and a `layout.erb` for your site's root route.

Additionally you will need to do the following to design and create your database:

- Create a database schema suitable for storing and organizing "tasks". Design this on paper or in a text editor first, and then translate it into SQL code using `CREATE TABLE`. Put this code in the `lib/database.rb` file, within the `create_schema` method.
- Write a database setup script, `create_schema.rb`, that creates the table(s) defined in your schema.

When you are done with the baseline it should be possible to setup your project on a different computer using the following bash commands:
```bash
$ git clone <SSH URL>
$ cd TaskListSinatra
$ bundle
$ ruby create_schema.rb
$ rerun 'ruby tasklist.rb'
```

## Primary Requirements

### Database Requirements
- Use a class that will keep track of the low-level database interaction.
  - The responsibility of this class is to create a database connection and also to create the database schema.
  - The file for this class exists already in `lib/database.rb`.
- Create a class that will inherit behavior from the database interaction class that will be responsible for all of the **task** record (row) persistence.
  - This will include inserting new tasks into the database, and selecting existing tasks from the database.

### Task Data Requirements
Each task record will include all of the following. Optional in this context means that the _user_ may choose not to provide this information, but it is still required for your schema:

- Self-incrementing identifier
- `title`: the title of the task (required)
- `description`: details about the task (optional)
- `completed_at`: the time and date the task was completed (optional)

### Web Requirements
- The home page (root route) of your Sinatra site should show the list of all of the tasks currently in the database.
- Be able to create a new task:
  - The home page should contain a link to add a new task. This will give the user a form to fill out with the appropriate task fields.
  - After the new task is added, the site should take the user back to the home page which displays the full list of tasks. The new task that was just added should be included in the full list of tasks.

## Optional Enhancements 
- Add the ability for the user to mark a task complete
  - Update the list of tasks on the home page to indicate which tasks are complete
  - Update the database interaction class to update a task's completed date
  - Use a form with checkboxes or radio buttons to allow a user to mark a task complete
- Add the ability for the user to delete an existing task, whether it is complete or not
  - Update the list of tasks on the home page to include a delete link
  - Before the system deletes the task, ask the user for confirmation
  - Update your database interaction class to delete from the database
- Add the ability for the user to edit the task
  - Re-use the form that was used for the Add task functionality
  - Update the list of tasks on the home page to include an edit link for each task
  - This includes updating your database interaction class to update the database
