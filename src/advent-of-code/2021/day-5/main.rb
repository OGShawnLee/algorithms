def create_matrix size
  Array.new(size) { Array.new(size, 0) }
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
    end
    if is_vertical_line(root, head)
      column_index = root[0]
      tail, peak = minmax(root[1], head[1])
      (tail..peak).each do |row_index|
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
