class Board

  attr_accessor :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def on_board?(x, y)
    x >= 0 && x < @width && y >= 0 && y < @height
  end

end
