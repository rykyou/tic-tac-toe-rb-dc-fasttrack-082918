# WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #first column
  [1,4,7], #second column
  [2,5,8], #third column
  [0,4,8], #diagonal
  [2,4,6], #another diagonal
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
  return index
end 

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true
  end 
end 

def turn(board)
  user_input = gets.strip
  index = input_to_index(user_input)
  
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else 
    turn(board)
  end 
end 

def turn_count(board)
  turn = 0 
  board.each do |index|
    if index == "X" || index == "O"
      turn += 1 
    end
  end
  return turn 
end

def current_player(board) 
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end 
end 

def won?(board)
  WIN_COMBINATIONS.each do |win_combonation|
    first_index = win_combonation[0]
    second_index = win_combonation[1]
    third_index = win_combonation[2]
      
    if board[first_index] == "X" && board[second_index] == "X" && board[third_index] == "X"
      return win_combonation
    elsif board[first_index] == "O" && board[second_index] == "O" && board[third_index] == "O"
      return win_combonation
    end 
  end 
  return false 
end 
  
def full?(board)
  board.all? {|index| index == "X" || index == "O" }
end 

def draw?(board)
  if !won?(board) && full?(board)
    return true 
  elsif won?(board)
  end
end

def over?(board)
  if full?(board) || won?(board)
    true 
  end
end

def winner(board)
  winning_array = won?(board)
  if winning_array == false
    nil
  elsif board[winning_array[0]] == "X"
    "X"
  elsif board[winning_array[0]] == "O"
    "O"
  end 
end 

def play(board)
  puts "Please enter 1-9:"
  until over?(board) == true || draw?(board) == true
    turn(board)
  end 
  
  if won?(board) 
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) 
    puts "Cat's Game!"
  end
end
