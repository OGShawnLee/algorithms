INPUT_FILE_PATH = "./input.txt"
EXAMPLE_FILE_PATH = "./example.txt"
LETTERS = ("a".."z").to_a
UPPERCASE_LETTERS = ("A".."Z").to_a

def find_repeated_char line
  first = line[0...line.length / 2]
  second = line[line.length / 2...line.length]
  first.each_char do |char|
    second.each_char do |inner_char|
      return char if char == inner_char
    end
  end
  raise "unable to find duplicate item #{line}"
end

def get_char_priority char
  LETTERS.each.with_index do |letter, index|
    return index + 1 if char == letter
    upper_char = UPPERCASE_LETTERS[index]
    return index + 1 + 26 if char == upper_char
  end
  raise "unable to get char priority #{char}"
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_items_priority_sum lines
  priority_count = 0
  for line in lines
    char = find_repeated_char(line)
    priority_count += get_char_priority(char)
  end
  return priority_count
end

example_lines = get_file_lines(EXAMPLE_FILE_PATH)
input_lines = get_file_lines(INPUT_FILE_PATH)
count = get_items_priority_sum(example_lines)
puts "Example Priority Sum: #{count}"
count = get_items_priority_sum(input_lines)
puts "Input Priority Sum: #{count}"
