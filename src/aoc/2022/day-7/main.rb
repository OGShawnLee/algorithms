class Directory
  attr_reader :name, :parent, :directories
  attr_accessor :size

  def initialize name, parent = nil
    @name = parent ? "#{parent.name}#{name}/" : name
    @parent = parent
    @directories = {}
    @files = {}
    @size = 0
  end

  def get_directory name
    @directories[name.to_sym]
  end

  def create_directory name
    if @directories.has_key?(name.to_sym)
      puts "Duplicate Directory"
    else
      directory = Directory.new(name, self)
      @directories[name.to_sym] = directory 
    end
  end

  def create_file name, size
    if @files.has_key?(name.to_sym)
      puts "Duplicate File"
    else
      file = File.new(name, size, self)
      @files[name.to_sym] = file 
      self.increment_size(size)
    end
  end

  def increment_size file_size
    current_dir = self
    while current_dir
      current_dir.size += file_size
      current_dir = current_dir.parent
    end
  end
end

class File
  def initialize name, size, parent
    @name = name
    @size = size
    @parent = parent
  end
end

def create_root_directory lines
  root = Directory.new("/")
  current_dir = root
  is_listing = false
  for line in lines
    if is_command(line)
      command = parse_command(line)
      case command[0]
      when "ls"
        is_listing = true
        next
      when "cd"
        is_listing = false
        target = command[1]
        case target
        when "/" then current_dir = root
        when ".."
          parent = current_dir.parent
          if parent 
            current_dir = parent
          end
        else
          current_dir = current_dir.get_directory(target)
        end
      end
    end
    if is_listing
      is_directory, (size, name) = parse_file(line)
      if is_directory
        current_dir.create_directory(name)
      else
        current_dir.create_file(name, size.to_i)
      end
    end  
  end
  root
end

def find_directories_by_max_size directory, max_size
  directories = []
  if directory.size <= max_size
    directories.append(directory.size) 
  end
  for directory in directory.directories.values
    directories.concat(
      find_directories_by_max_size(directory, max_size)
    )
  end
  directories
end

def get_directories_by_max_size_sum directory, max_size
  directories = find_directories_by_max_size(directory, max_size)
  directories.reduce(:+)
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def is_command line
  line[0] == "$"
end

def parse_file line
  attributes = line.split(" ")
  is_directory = attributes[0] == "dir"
  return is_directory, attributes
end

def parse_command line
  line[2..].split(" ")
end

FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
MAXIMUM_DIR_SIZE = 100_000

lines = get_file_lines(FILE_PATH_EXAMPLE)
root_dir = create_root_directory(lines)
count = get_directories_by_max_size_sum(root_dir, MAXIMUM_DIR_SIZE)
puts "Example File Results:"
puts "-- Directories Sum: #{count}"

lines = get_file_lines(FILE_PATH_INPUT)
root_dir = create_root_directory(lines)
count = get_directories_by_max_size_sum(root_dir, MAXIMUM_DIR_SIZE)
puts "Input File Results:"
puts "-- Directories Sum: #{count}"
