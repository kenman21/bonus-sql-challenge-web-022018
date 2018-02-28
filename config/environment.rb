require 'bundler'
require_relative '../lib/queries'
require_relative '../db/seed'
require 'pry'

Bundler.require

# Setup a DB connection here

DB = {:conn => SQLite3::Database.new("database.db")}
