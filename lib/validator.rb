class Validator
  SYMBOLS_IN_SUDOKU = 81

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    board_string = @puzzle_string.gsub(/\D/, '')
    if board_string.length > SYMBOLS_in_SUDOKU || contains_duplicates(board_string)
      return 'Sudoku is invalid.'
    elsif board_string.include? '0'
      return 'Sudoku is valid but incomplete.'
    else 
      return 'Sudoku is valid.'
    end   
  end

  def contains_duplicates(board_string)
    board_array = create_board_array(board_string)
    rows = []
    colums = []
    boxes = []
    for i in 0...board_array.size do
      for j in 0...board_array.size do 
        symbol_to_check = board_array[i][j]
        if symbol_to_check != 0
          if (colums.include? [j, symbol_to_check]) || (rows.include? [i, symbol_to_check]) || (boxes.include? [i/3,j/3, symbol_to_check])
            return true
          else
            colums.push([j, symbol_to_check])
            rows.push([i, symbol_to_check])
            boxes.push([i/3, j/3, symbol_to_check])
          end
        end       
      end
    end  
    return false
  end

  def create_board_array(board_string)
    board = []
    for i in 0...board_string.length do
      if i % 9 == 0
        board.push(board_string[i...i + 9].split('').map(&:to_i))
      end
    end
    board
  end

end
