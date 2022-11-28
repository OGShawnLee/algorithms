class Board
  attr_reader :rows

  def initialize 
    @rows = []
    @column_counters = Array.new(5, 0)
  end

  def get_board_score win_number
    uncrossed_count = @rows.reduce(0) do |count, row|
      count + row.tiles.reduce(0) do |count, tile|
        count + (tile.is_crossed ? 0 : tile.value)
      end
    end
    uncrossed_count * win_number
  end

  def cross row_index, tile_index
    has_won_with_row = @rows[row_index].cross(tile_index)
    @column_counters[tile_index] += 1
    column_count = @column_counters[tile_index]
    has_won_with_column = column_count == 5
    if has_won_with_row and has_won_with_column
      return true, "Cross!"
    end
    if has_won_with_row
      return has_won_with_row, "Row"
    end
    if has_won_with_column
      return true, "Column"
    end
    return false, "None"
  end

  def push row
    @rows.push(row)
  end

  def is_full
    @rows.length == 5
  end
end

class Row
  attr_reader :tiles

  def initialize line
    @count = 0
    @tiles = Row.parse_line(line)
    @is_completed = false
  end

  def cross tile_index
    tile = @tiles[tile_index]
    tile.cross
    @count += 1
    self.has_won
  end

  def has_won
    @count == 5
  end 

  def self.parse_line line
    line
      .gsub(/\s/, " ")
      .split(" ")
      .map { |char| Tile.new(char.to_i) }
  end
end

class Tile
  attr_reader :value
  attr_reader :is_crossed

  def initialize value
    @value = value
    @is_crossed = false
  end

  def cross
    @is_crossed = true
  end
end

def get_boards_and_rounds lines
  boards = []
  rounds = lines[0].split(",").map { |char| char.to_i }
  is_collecting_board = false
  for line in lines
    if is_collecting_board
      board = boards.last
      board.push(Row.new(line))
      if board.is_full
        is_collecting_board = false 
      end
    end
    if line.strip == ""
      is_collecting_board = true
      boards.push(Board.new)
    end
  end
  return boards, rounds
end

def get_first_board_winner lines
  boards, rounds = get_boards_and_rounds(lines)
  for round in rounds
    for board in boards
      board.rows.each.with_index do |row, row_index|
        row.tiles.each.with_index do |tile, tile_index|
          is_already_crossed = tile.is_crossed
          next if tile.value != round or is_already_crossed
          has_won, win_text = board.cross(row_index, tile_index)
          return board, tile.value, win_text if has_won 
        end
      end
    end
  end
end

def get_file_lines file_path
  IO.readlines(file_path)
end

def print_results file_name, score, win_number, win_line
  puts " -- Results from #{file_name}:"
  puts " ---- Winner Board Score #{score} | Winner Number #{win_number} | Won in: #{win_line}"
end

EXAMPLE_FILE_PATH ="./example.txt"
INPUT_FILE_PATH = "./input.txt"

lines = get_file_lines(EXAMPLE_FILE_PATH)
board, win_number, win_line = get_first_board_winner(lines)
score = board.get_board_score(win_number)
puts "First Board Winner"
print_results("Example File", score, win_number, win_line)
lines = get_file_lines(INPUT_FILE_PATH)
board, win_number, win_line = get_first_board_winner(lines)
score = board.get_board_score(win_number)
print_results("Input File", score, win_number, win_line)
