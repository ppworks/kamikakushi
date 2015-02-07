require 'rails/all'
require 'kamikakushi'
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection :test

class Post < ActiveRecord::Base
  kamikakushi
  attr_accessor :comment_after_destroy
  has_many :comments
  before_destroy :set_before_destroy
  after_destroy :set_after_destroy

  def set_before_destroy
    return false if self.protected
  end

  def set_after_destroy
    self.comment_after_destroy = "KAMIKAKUSHI"
  end
end

class Comment < ActiveRecord::Base
  kaonashi parent: :post
  belongs_to :post
end

class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:posts) do |t|
      t.string :title
      t.boolean :protected
      t.datetime :deleted_at
    end

    create_table(:comments) do |t|
      t.integer :post_id
      t.text :content
    end
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up
