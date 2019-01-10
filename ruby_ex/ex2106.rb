require 'rubygems'
require 'dbi'

dbh = DBI.connect('DBI:SQLite3:students01.db')

dbh.select_all('select * from students where age<10') do |row|
  print "row=#{row.to_a}             \n"
  print "  name = #{row[0]}\n"
  print "  age  = #{row[1]}\n"
  print "\n"
end

dbh.disconnect
