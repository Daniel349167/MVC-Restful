=begin
A toy Sinatra app to demonstrate the basic concept of MVC, RESTful Routes and CRUD.
Run ``bundle install`` to make sure you have necessary gems installed.
TO run the script, type ``ruby template.rb`` in command line.
updated: jeremy warner, original author: hezheng.yin
=end

# load libraries we need
require 'sinatra'
require 'active_record'
require 'json'

# tell active_record which database to connect to
db_options = {adapter: 'sqlite3', database: 'todos_db'}
ActiveRecord::Base.establish_connection(db_options)

# write migration class for creating Todo table in database
### how do we write migration in rails?
class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :description
    end
  end
end

# create Todo table by executing the function we just wrote
### how do apply migration in rails?
### why do we handle exception here?
begin
  CreateTodos.new.change
rescue ActiveRecord::StatementInvalid
  # it's probably OK
end

# create Todo class by inheriting from ActiveRecord::Base
### how do we write new class in Rails?
### why there's no setter and getter method (or attr_accessor)?
class Todo < ActiveRecord::Base
end

# populate the database if it is empty (avoid running this piece of code twice)
### do you still remember this cleaner and simpler hash syntax?
# old version: new_hash = {:simon => "Talek", :lorem => "Ipsum"}
if Todo.all.empty?
  Todo.create(description: "prepare for discussion section")
  Todo.create(description: "release cc 3s2")
end

# display all todos
get '/todos' do
  content_type :json
  Todo.all.to_json
end

# show a specific todo
get '/todos/:id' do
  content_type :json
  todo = Todo.find_by_id(params[:id])
  if todo
    return {description: todo.description}.to_json
  else
    return {msg: "error: specified todo not found"}.to_json
  end
end



# create a new todo
post '/todos' do
  content_type :json
  if params[:description] && !params[:description].empty?
    Todo.create(description: params[:description])
    {msg: "create success"}.to_json
  else
    {msg: "error: description can't be blank"}.to_json
  end
end

# update a todo
put '/todos/:id' do
  content_type :json
  todo = Todo.find_by_id(params[:id])
  if todo && params[:description] && !params[:description].empty?
    todo.update_attribute(:description, params[:description])
    {msg: "update success"}.to_json
  else
    {msg: "update failure"}.to_json
  end
end

# delete a todo
delete '/todos/:id' do
  content_type :json
  todo = Todo.find_by_id(params[:id])
  if todo
    todo.destroy
    {msg: "delete success"}.to_json
  else
    {msg: "delete failure"}.to_json
  end
end

