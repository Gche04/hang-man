require_relative 'hang_man.rb'

puts ""
puts "to load saved game, enter the apprioprate Player-name and password"
puts ""

print "enter Player-name -->  "
name = gets.chomp.downcase

print "enter Player-password -->  "
password = gets.chomp.downcase
puts ""

p = HangMan.new(name, password)
p.start_game
