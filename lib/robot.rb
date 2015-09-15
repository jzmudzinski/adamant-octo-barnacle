class Robot

  FACING = ["NORTH", "EAST", "SOUTH", "WEST"]
  COMMANDS = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]

  attr_accessor :x, :y, :facing

  def initialize(board)
    @board = board
    @command_list = []
    @current_command = nil
    @output = ""
  end

  def place(x, y, facing)
    @x = x
    @y = y
    @facing = facing
    validate_position_on_board && validate_facing
  end

  def move
    return false unless validate_position_on_board
    if @board.on_board?(@x + x_modifier.to_i, @y + y_modifier.to_i)
      @x += x_modifier.to_i
      @y += y_modifier.to_i
    else
      false
    end
  end

  def left
    return false unless validate_position_on_board
    rotate(-1)
  end

  def right
    return false unless validate_position_on_board
    rotate(1)
  end

  def report
    "#{@x},#{@y},#{@facing}"
  end

  def load_program(code)
    @commands = code.split(" ")
    @commands.each_with_index do |command, i|
      if command == "PLACE"
        @command_list << command + " " + @commands[i+1]
        @commands[i+1] = nil
      elsif COMMANDS.include?(command)
        @command_list << command
      end
    end
    @command_list.any?
  end

  def run_program
    @command_list.each do |command|
      self.issue(command)
    end
    @output
  end

  def issue(command)
    c = command.split " "
    return false unless COMMANDS.include? c[0]
    to_execute = "self.#{c[0].downcase}"
    if !c[1].nil?
      params = c[1].split(",")
      params[-1] = "'#{params[-1]}'"
      to_execute << "(#{params.join(",")})"
    end
    response = eval(to_execute)
    @output << response if response && response.kind_of?(String)
  end

  private

  def validate_position_on_board
    !(@x.nil? || @y.nil? || @facing.nil?) && @board.on_board?(@x, @y)
  end

  def validate_facing
    FACING.include? @facing
  end

  def x_modifier
    case @facing
    when "NORTH" || "SOUTH"
      0
    when "EAST"
      1
    when "WEST"
      -1
    end
  end

  def y_modifier
    case @facing
    when "EAST" || "WEST"
      0
    when "SOUTH"
      -1
    when "NORTH"
      1
    end
  end

  def rotate(steps)
    @facing = FACING[(FACING.index(@facing) + steps) % FACING.length]
    true
  end

end
