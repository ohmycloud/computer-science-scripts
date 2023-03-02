$x = 5

def print_x
  $x = 10
  puts $x - 6
end

print_x
puts($x)