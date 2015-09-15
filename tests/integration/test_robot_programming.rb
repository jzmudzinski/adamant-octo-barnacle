require_relative '../tests_helper'

class TestRobotProgramming < Minitest::Test

  def setup
    @board = Board.new(5, 5)
    @robot = Robot.new(@board)
  end

  def test_code_chunk1
    program = "PLACE 0,0,NORTH MOVE REPORT"
    @robot.load_program(program)
    assert_equal "0,1,NORTH", @robot.run_program
  end

  def test_code_chunk2
    program = "PLACE 0,0,NORTH LEFT REPORT"
    @robot.load_program(program)
    assert_equal "0,0,WEST", @robot.run_program
  end

  def test_code_chunk3
    program = "PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT"
    @robot.load_program(program)
    assert_equal "3,3,NORTH", @robot.run_program
  end

  def test_code_chunk4
    program = "PLACE 0,0,WEST MOVE MOVE MOVE MOVE REPORT"
    @robot.load_program(program)
    assert_equal "0,0,WEST", @robot.run_program
  end

  def test_code_chunk5
    program = "PLACE 4,4,EAST MOVE MOVE MOVE MOVE REPORT"
    @robot.load_program(program)
    assert_equal "4,4,EAST", @robot.run_program
  end

  def test_code_chunk6
    program = "PLACE 0,0,SOUTH MOVE MOVE MOVE MOVE REPORT"
    @robot.load_program(program)
    assert_equal "0,0,SOUTH", @robot.run_program
  end

  def test_code_chunk7
    program = "PLACE 4,0,EAST MOVE MOVE MOVE MOVE REPORT"
    @robot.load_program(program)
    assert_equal "4,0,EAST", @robot.run_program
  end

end
