# https://adventofcode.com/2021/day/01

# part 1

# open file and get ints
input = File.open("input.txt")
input_ints = input.readlines.map {|line| line.chomp.to_i}

# get number of value increases
def get_number_of_value_increases(arr)
    # number of timese value increased
    n_increased = 0
    previous = arr[0]
    arr[1..-1].each do |x|
        (x - previous > 0)?  n_increased += 1 : nil
        previous = x
    end
    return n_increased
end

puts "number increased: #{get_number_of_value_increases(input_ints)}"

# part 2

# get sums of sliding window
window_size = 3
window_sums = []
for i in 0...input_ints.length do
    sum = input_ints[i...(i + window_size)].sum
    window_sums += [sum]
end

puts "number increased: #{get_number_of_value_increases(window_sums)}"

