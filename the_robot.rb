#!/usr/bin/env ruby
require './lib/toy_robot'

programs = []

# A file is passed in as an argument
if ARGV.length > 0
  programs = IO.readlines(ARGV[0])
else
  print "Enter program: "
  programs[0] = gets
end

programs.each do |program|
  robot = Robot.new(Board.new(5,5))
  robot.load_program(program)
  puts robot.run_program
end
