require 'rails/all'
require 'kamikakushi'
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection :test

class Post < ActiveRecord::Base
  include Kamiakushi
end

class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:posts) {|t| t.string :title;t.datetime :deleted_at}
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up
