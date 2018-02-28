# Write methods that return SQL queries for each part of the challeng here

module Queries

  def guest_with_most_appearances
    sql = <<-SQL
    SELECT raw_guest_list, COUNT(raw_guest_list) FROM daily_show_guests
    GROUP BY raw_guest_list ORDER BY COUNT(raw_guest_list)  DESC LIMIT 1
    SQL

    DB[:conn].execute(sql)[0][0]
  end

  def most_popular_profession
    sql = <<-SQL
    SELECT year FROM daily_show_guests
    GROUP BY year
    SQL

    sql2 = <<-SQL
    SELECT occupation, COUNT(occupation) FROM daily_show_guests
    WHERE year = ?
    GROUP BY occupation
    ORDER BY COUNT(occupation) DESC LIMIT 1
    SQL

    years = DB[:conn].execute(sql).flatten

    years.map do |year|
      DB[:conn].execute(sql2, year)
    end
  end

  def overall_most_popular_profession

    sql = <<-SQL
    SELECT occupation, COUNT(occupation) FROM daily_show_guests
    GROUP BY occupation
    ORDER BY COUNT(occupation) DESC LIMIT 1
    SQL

    DB[:conn].execute(sql).flatten

  end

  def first_name_bill

    sql = <<-SQL
    SELECT COUNT(raw_guest_list) FROM daily_show_guests
    WHERE raw_guest_list LIKE "Bill%"
    GROUP BY raw_guest_list
    SQL

    total = 0

    DB[:conn].execute(sql).flatten.each do |bill|
      total += bill
    end

    total

  end

  def patrick_stewart
    sql = <<-SQL
    SELECT year FROM daily_show_guests
    WHERE raw_guest_list = "Patrick Stewart\n"
    SQL

    DB[:conn].execute(sql).flatten

  end

  def most_guests
    sql = <<-SQL
    SELECT year, COUNT(raw_guest_list) FROM daily_show_guests
    GROUP BY year
    ORDER BY COUNT(raw_guest_list) DESC LIMIT 1
    SQL

    DB[:conn].execute(sql).flatten
  end

  def most_popular_group
    sql = <<-SQL
    SELECT year FROM daily_show_guests
    GROUP BY year
    SQL

    sql2 = <<-SQL
    SELECT group_name, COUNT(occupation) FROM daily_show_guests
    WHERE year = ?
    GROUP BY group_name
    ORDER BY COUNT(group_name) DESC LIMIT 1
    SQL

    years = DB[:conn].execute(sql).flatten

    years.map do |year|
      DB[:conn].execute(sql2, year)
    end
  end

end
