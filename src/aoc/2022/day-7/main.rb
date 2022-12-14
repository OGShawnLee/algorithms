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

def find_smallest_deletable_directory directory
  free_space = DISK_SIZE - directory.size 
  needed_space = UPDATE_SIZE - free_space
  smallest_dir = directory
  directories = get_directories_with_size(directory)
  for dir, size in directories
    if size >= needed_space && size < smallest_dir.size
      smallest_dir = dir
    end
  end
  smallest_dir
end

def get_directories_by_max_size_sum directory, max_size
  directories = find_directories_by_max_size(directory, max_size)
  directories.reduce(:+)
end

def get_directories_with_size directory
  directories = [[directory, directory.size]]
  for dir in directory.directories.values
    directories.concat(
      get_directories_with_size(dir)
    )
  end
  directories
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

def print_results file_name, count, smallest_dir
  puts "#{file_name} File Results:"
  puts "-- Directories Sum: #{count}"
  puts "-- Smallest Deletable Directory: #{smallest_dir.name} | Size: #{smallest_dir.size}"
end

DISK_SIZE = 70_000_000
FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
MAXIMUM_DIR_SIZE = 100_000
UPDATE_SIZE = 30_000_000

lines = get_file_lines(FILE_PATH_EXAMPLE)
root_dir = create_root_directory(lines)
count = get_directories_by_max_size_sum(root_dir, MAXIMUM_DIR_SIZE)
smallest_dir = find_smallest_deletable_directory(root_dir)
print_results("Example", count, smallest_dir)

lines = get_file_lines(FILE_PATH_INPUT)
root_dir = create_root_directory(lines)
count = get_directories_by_max_size_sum(root_dir, MAXIMUM_DIR_SIZE)
smallest_dir = find_smallest_deletable_directory(root_dir)
print_results("Input", count, smallest_dir)
