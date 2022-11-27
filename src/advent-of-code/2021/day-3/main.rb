class BitCounter
  def initialize
    @on = 0
    @off = 0
  end

  def count bit_char
    if bit_char == "0"
      @off += 1
    elsif bit_char == "1"
      @on += 1
    end
  end
  
  def get_common_bit_char
    if @on > @off then "1" else "0" end
  end

  def get_uncommon_bit_char
    if @on > @off then "0" else "1" end
  end
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_epsilon_gamma_rates lines, bit_length
  epsilon_rate = ""
  gamma_rate = ""
  counters = Array.new(bit_length) { BitCounter.new }
  for line in lines
    line.split("").each.with_index do |bit_char, index|
      counter = counters[index]
      counter.count(bit_char)
    end
  end
  for counter in counters
    epsilon_rate += counter.get_uncommon_bit_char
    gamma_rate += counter.get_common_bit_char
  end
  return epsilon_rate.to_i(2), gamma_rate.to_i(2)
end

def get_submarine_power_consumption lines, bit_length
  epsilon_rate, gamma_rate = get_epsilon_gamma_rates(lines, bit_length)
  epsilon_rate * gamma_rate
end  

EXAMPLE_FILE_PATH = "./example.txt"
EXAMPLE_BIT_LENGTH = 5
INPUT_FILE_PATH = "./input.txt"
INPUT_BIT_LENGTH = 12

lines = get_file_lines(EXAMPLE_FILE_PATH)
power_consumption = get_submarine_power_consumption(lines, EXAMPLE_BIT_LENGTH)
puts "Example File Results:"
puts "Submarine Power Consumption: #{power_consumption}" 
lines = get_file_lines(INPUT_FILE_PATH)
power_consumption = get_submarine_power_consumption(lines, INPUT_BIT_LENGTH)
puts "Input File Results:"
puts "Submarine Power Consumption: #{power_consumption}" 

