require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-validations'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize