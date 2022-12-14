from pathlib import Path
from typing import Union

class Directory:
  def __init__(self, name: str, parent: Union['Directory', None] =  None):
    self.name = f"{parent.name}{name}/" if parent else name 
    self.files: dict[str, File] = {}
    self.directories: dict[str, Directory] = {}
    self.parent = parent
    self.size = 0

  def create_directory(self, name: str):
    if name in self.directories:
      print("Directory Already Created")
    else:
      directory = Directory(name, self)
      self.directories[name] = directory

  def create_file(self, name: str, size: int):
    if name in self.files:
      print("File Already Created")
    else:
      file = File(name, size, self)
      self.files[name] = file
      self.increment_size(size)

  def increment_size(self, file_size: int):
      current_dir = self
      while current_dir:
        current_dir.size += file_size
        current_dir = current_dir.parent

class File:
  def __init__(self, name: str, size: int, parent: Directory):
    self.name = f"{parent.name}{name}"
    self.size = size
    self.parent = parent

def create_root_directory(lines: list[str]):
  is_listing_directories = False
  root = Directory("/")
  current_dir = root
  for line in lines:
    if is_command(line):
      command = parse_command(line)
      if command[0] == "ls":
        is_listing_directories = True
        continue
      if command[0] == "cd":
        is_listing_directories = False
        value = command[1]
        if value == "/":
          current_dir = root
        elif value == "..":
          parent = current_dir.parent
          if parent:
            current_dir = current_dir.parent
        else:
          current_dir = current_dir.directories[value]
    if is_listing_directories:
      is_directory, (size, name) = parse_file(line)
      if is_directory:
        current_dir.create_directory(name)
      else:
        current_dir.create_file(name, int(size))
  return root

def find_smallest_deletable_directory(directory: Directory):
  free_space = DISK_SIZE - directory.size
  needed_space = UPDATE_SIZE - free_space
  smallest_dir = directory
  directories = get_directories_with_size(directory)
  for current_dir, dir_size in directories:
    if dir_size >= needed_space and dir_size < smallest_dir.size:
      smallest_dir = current_dir
  return smallest_dir

def find_directories_by_max_size(directory: Directory, max_size: int):
  directories = []
  if directory.size <= max_size:
    directories.append(directory.size)
  for directory in directory.directories.values():
    directories.extend(
      find_directories_by_max_size(directory, max_size)
    )
  return directories

def get_directories_by_max_size_sum(directory: Directory, max_size: int):
  directories = find_directories_by_max_size(directory, max_size)
  return sum(directories)

def get_directories_with_size(directory: Directory):
  directories = [(directory, directory.size)]
  for current_dir in directory.directories.values():
    directories.extend(
      get_directories_with_size(current_dir)
    )
  return directories

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def is_command(line: str):
  return line[0] == "$"

def parse_command(line: str):
  return line[2:].split(" ")

def parse_file(line: str):
  attributes = line.split(" ")
  is_directory = attributes[0] == "dir"
  return is_directory, attributes

DISK_SIZE = 70_000_000
FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
MAXIMUM_DIR_SIZE = 100_000
UPDATE_SIZE = 30_000_000

if __name__ == "__main__":
  lines = get_file_lines(FILE_PATH_EXAMPLE)
  root_dir = create_root_directory(lines)
  count = get_directories_by_max_size_sum(root_dir, MAXIMUM_DIR_SIZE)
  print("Example File Results:")
  print(f"-- Directories Sum: {count}")
  dir_with_size = get_directories_with_size(root_dir)
  smallest_dir = find_smallest_deletable_directory(root_dir)
  print(f"-- Smallest Deletable Directory: {smallest_dir.name} | Size: {smallest_dir.size}")

  lines = get_file_lines(FILE_PATH_INPUT)
  root_dir = create_root_directory(lines)
  count = get_directories_by_max_size_sum(root_dir, MAXIMUM_DIR_SIZE)
  print("Input File Results:")
  print(f"-- Directories Sum: {count}")
  smallest_dir = find_smallest_deletable_directory(root_dir)
  print(f"-- Smallest Deletable Directory: {smallest_dir.name} | Size: {smallest_dir.size}")
  