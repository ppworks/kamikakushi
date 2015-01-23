ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection :test

class Post < ActiveRecord::Base
  include KamiKakushi
end

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:posts) {|t| t.string :title}
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up

require 'rails_helper'

RSpec.describe KamiKakushi do
  before do
    post = Post.create(title: 'hoge')
    puts post
  end
end
