require "pry"
require "rails/all"
require "sqlite3"

class DummyApp < Rails::Application
  config.root = Pathname(__dir__)
  config.eager_load = false
  config.secret_key_base = "x"
end

Rails.application.initialize!

ActiveRecord::Base.connection.create_table "companies" do |t|
  t.string "name"
end

ActiveRecord::Base.connection.create_table "users" do |t|
  t.string "name"
  t.integer "company_id"
end

class Company < ActiveRecord::Base
  has_many :users, foreign_key: :company_id, class_name: "::User"
end

class User < ActiveRecord::Base
  belongs_to :company, class_name: "::Company"
end

company = Company.create(name: "Reflektive, Inc.")
User.create(name: "Tony", company: company)
User.create(name: "Miguel", company: company)
