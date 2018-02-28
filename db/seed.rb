# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require 'csv'
require 'sqlite3'
require 'pry'
require_relative '../config/environment'


csv_array = []

File.open('daily_show_guests.csv').each do |row|
  csv_array << row.split(",")
end

csv_array.shift

class Dailyshow

  extend Queries

  attr_accessor :id, :year, :googleknowlege_occupation, :show, :group_name, :raw_guest_list

  def initialize(year, googleknowlege_occupation, show, group_name, raw_guest_list, id=nil)
    @id = id
    @year = year
    @occupation = googleknowlege_occupation
    @show = show
    @group_name = group_name
    @Raw_Guest_List = raw_guest_list
  end


  def self.create_table
    sql = <<-SQL
    CREATE TABLE daily_show_guests (
    id INTEGER PRIMARY KEY,
    year TEXT,
    occupation TEXT,
    show TEXT,
    group_name TEXT,
    raw_guest_list TEXT)
    SQL

    DB[:conn].execute(sql)
  end

  def self.insert_all(csv_array)
    sql2 = <<-SQL
    INSERT INTO daily_show_guests(year, occupation, show, group_name, raw_guest_list)
    VALUES (?, ?, ?, ?, ?)
    SQL

    csv_array.each do |row|
      DB[:conn].execute(sql2, row[0], row[1], row[2], row[3], row[4])
    end
  end

end
binding.pry
puts "hello"



# class Dailyshow
#
#   attr_accessor :id, :year, :googleknowlege_occupation, :show, :group_name, :raw_guest_list
#
#   def initialize(id=nil, year, googleknowlege_occupation, show, group_name, raw_guest_list)
#     @id = id
#     @year = year
#     @GoogleKnowlege_Occupation = googleknowlege_occupation
#     @show = show
#     @group_name = group_name
#     @Raw_Guest_List = raw_guest_list
#   end
#
#   def self.create_table
#     sql = <<-SQL
#     CREATE TABLE daily_show_guests (
#     id INTEGER PRIMARY KEY,
#     year INTEGER,
#     googleknowlege_occupation TEXT,
#     show TEXT,
#     group_name TEXT,
#     raw_guest_list Text
#     SQL
#
#     DB[:conn].execute(sql)
#
#   end
#
# end
