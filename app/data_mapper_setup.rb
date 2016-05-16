require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-validations'
require './app/models/space.rb'
require './app/models/user.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
