mark = Hash.new 0
mark['English'] = 50
mark['Math'] = 70
mark['Science'] = 75

sub = gets.chop

puts "Mark in #{sub} is #{mark[sub]}" if mark[sub]