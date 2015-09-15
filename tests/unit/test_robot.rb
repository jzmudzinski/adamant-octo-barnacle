require_relative '../tests_helper'

class TestRobot < Minitest::Test

  def setup
    @board = Board.new(5, 5)
    @robot = Robot.new(@board)
  end

  def test_place
    assert_equal true, @robot.place(1, 2, "NORTH")
  end

  def test_move
    @robot.place(1,1,"SOUTH")
    @robot.move
    assert_equal 0, @robot.y
  end

  def test_left
    @robot.place(1,1,"SOUTH")
    @robot.left
    assert_equal "EAST", @robot.facing
    @robot.left
    assert_equal "NORTH", @robot.facing
    @robot.left
    assert_equal "WEST", @robot.facing
    @robot.left
    assert_equal "SOUTH", @robot.facing
    @robot.left
    assert_equal "EAST", @robot.facing
  end

  def test_right
    @robot.place(1,1,"WEST")
    @robot.right
    assert_equal "NORTH", @robot.facing
    @robot.right
    assert_equal "EAST", @robot.facing
    @robot.right
    assert_equal "SOUTH", @robot.facing
    @robot.right
    assert_equal "WEST", @robot.facing
    @robot.right
    assert_equal "NORTH", @robot.facing
  end

  def test_invalid_placement_facing
    assert_equal false, @robot.place(1, 2, "NORTHasfd")
    assert_equal false, @robot.place(1, 2, "NORTH-EAST")
  end

  def test_invalid_placement_off_board
    assert_equal false, @robot.place(-1, 2, "NORTH")
    assert_equal false, @robot.place(1, -2, "NORTH")
    assert_equal false, @robot.place(5, 2, "NORTH")
    assert_equal false, @robot.place(2, 5, "NORTH")
  end

  def test_movement_off_board
    @robot.place(0,0,"SOUTH")
    assert_equal false, @robot.move
    assert_equal 0, @robot.y
  end

  def test_report
    @robot.place(0,0,"SOUTH")
    assert_equal "0,0,SOUTH", @robot.report
  end

  def test_issuing_a_place_command
    @robot.issue("PLACE 0,0,SOUTH")
    assert_equal "0,0,SOUTH", @robot.report
  end

  def test_issuing_a_move_command
    @robot.place(1,1,"SOUTH")
    @robot.issue("MOVE")
    assert_equal "1,0,SOUTH", @robot.report
  end

  def test_issuing_a_left_command
    @robot.place(1,1,"SOUTH")
    @robot.issue("LEFT")
    assert_equal "1,1,EAST", @robot.report
  end

  def test_issuing_a_right_command
    @robot.place(1,1,"SOUTH")
    @robot.issue("RIGHT")
    assert_equal "1,1,WEST", @robot.report
  end

  def test_loading_a_program
    program = "PLACE 0,0,SOUTH LEFT MOVE"
    assert_equal true, @robot.load_program(program)
  end

  def test_running_a_program
    program = "PLACE 0,0,SOUTH LEFT LEFT MOVE MOVE MOVE REPORT"
    @robot.load_program(program)
    assert_equal "0,3,NORTH", @robot.run_program
  end

end
