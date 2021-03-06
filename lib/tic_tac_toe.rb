class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O" }
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

#  def won?
#    WIN_COMBINATIONS.each do |index_array|
#      combo = []
#      index_array.each do |index|
#        combo << @board[index]
#      end
#      if combo.all? { |move| move == "X" } || combo.all? { |move| move == "O" }
#        return index_array
#      end
#    end
#    return false
#  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      combo.all? { |index| @board[index] == "X" } || combo.all? { |index| @board[index] == "O"}
    end
  end

  def full?
    @board.all? { |element| element == "X" || element == "O" }
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      puts "Congratulations #{@board[won?[0]]}!"
      return @board[won?[0]]
    else
      puts "Cat's Game!"
    end
  end

  def play
    while !over?
      turn
    end
    winner
  end

end
