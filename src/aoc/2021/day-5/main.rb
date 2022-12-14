def create_matrix size
  Array.new(size) { Array.new(size, 0) }
end

def get_diagonal_coordinates root, head
  min_x, max_x = minmax(root[0], head[0])
  min_y, max_y = minmax(root[1], head[1])
  is_x_ascending = root[0] < head[0]
  is_y_ascending = root[1] < head[1]
  coordinates_length = max_x + 1 - min_x
  coordinates = Array.new(coordinates_length) { [0, 0] }
  handle_x = 
  if is_x_ascending
    -> (coordinate) { 
      coordinate[0] = min_x
      min_x += 1 
    }
  else 
    -> (coordinate) {
      coordinate[0] = max_x
      max_x -= 1 
    }
  end
  handle_y = 
  if is_y_ascending
    -> (coordinate) {
      coordinate[1] = min_y
      min_y += 1
    }
  else
    -> (coordinate) {
      coordinate[1] = max_y
      max_y -= 1
    }
  end
  for coordinate in coordinates
    handle_x.call(coordinate)
    handle_y.call(coordinate)
  end
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_overlapped_count file_path, matrix
  get_file_lines(file_path).reduce(0) do |count, line|
    root, head = parse_line_coordinates(line)
    if is_horizontal_line(root, head)
      row = matrix[root[1]]
      tail, peak = minmax(root[0], head[0])
      (tail..peak).each do |column_index|
        row[column_index] += 1
        tile = row[column_index]
        count += 1 if tile == 2 
      end
    elsif is_vertical_line(root, head)
      column_index = root[0]
      tail, peak = minmax(root[1], head[1])
      (tail..peak).each do |row_index|
        matrix[row_index][column_index] += 1
        tile = matrix[row_index][column_index]
        count += 1 if tile == 2
      end
    else
      coordinates = get_diagonal_coordinates(root, head)
      for column_index, row_index in coordinates
        matrix[row_index][column_index] += 1
        tile = matrix[row_index][column_index]
        count += 1 if tile == 2
      end 
    end
    count
  end  
end

def is_horizontal_line root, head
  root[1] == head[1]
end

def is_vertical_line root, head
  root[0] == head[0]
end

def minmax a, b
  a > b ? [b, a] : [a, b]
end

def parse_line_coordinates line
  line.split(" -> ").map do |pair| 
    pair.split(",").map { |str| str.to_i }
  end
end

def print_matrix matrix
  for row in matrix
    letters = row.map { |ltr| ltr.to_s }
    first_letter = letters[0]
    (1..letters.length).each do |index|
      letter = letters[index]
      first_letter += "\t#{letter}"
    end
    puts(first_letter)
  end
end

def print_result file_name, count, matrix
  puts "#{file_name} File Results:"
  print_matrix(matrix) if matrix.length <= 10
  puts "--> Overlapped Count #{count}"
end

EXAMPLE_FILE_PATH = "./example.txt"
EXAMPLE_MATRIX_SIZE = 10
INPUT_FILE_PATH = "./input.txt"
INPUT_MATRIX_SIZE = 1000

matrix = create_matrix(EXAMPLE_MATRIX_SIZE)
count = get_overlapped_count(EXAMPLE_FILE_PATH, matrix) 
print_result("Example", count, matrix)
matrix = create_matrix(INPUT_MATRIX_SIZE)
count = get_overlapped_count(INPUT_FILE_PATH, matrix) 
print_result("Input", count, matrix)
