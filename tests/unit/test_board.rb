require_relative '../tests_helper'

class TestBoard < Minitest::Test

  def setup
    @board = Board.new(5, 5)
  end

  def test_on_board_if_on
    assert_equal true, @board.on_board?(0,0)
    assert_equal true, @board.on_board?(1,0)
    assert_equal true, @board.on_board?(1,4)
    assert_equal true, @board.on_board?(4,4)
  end

  def test_on_board_if_off_west
    assert_equal false, @board.on_board?(-1,0)
  end

  def test_on_board_if_off_east
    assert_equal false, @board.on_board?(6,0)
  end

  def test_on_board_if_off_north
    assert_equal false, @board.on_board?(1,6)
  end

  def test_on_board_if_off_south
    assert_equal false, @board.on_board?(4,-1)
  end

end
