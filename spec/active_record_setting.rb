require 'rails/all'
require 'kamikakushi'
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection :test

class Post < ActiveRecord::Base
  include Kamikakushi
  attr_accessor :comment_after_destroy
  before_destroy :set_before_destroy
  after_destroy :set_after_destroy

  def set_before_destroy
    return false if self.protected
  end

  def set_after_destroy
    self.comment_after_destroy = "KAMIKAKUSHI"
  end
end

class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:posts) do |t|
      t.string :title
      t.boolean :protected
      t.datetime :deleted_at
    end
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up
