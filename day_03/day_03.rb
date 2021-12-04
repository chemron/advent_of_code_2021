# https://adventofcode.com/2021/day/03

input = File.open("test_input.txt")

lines = input.readlines

# convert to matrix of integers
matrix = lines.map {|line| line.chomp.split("").map(&:to_i)}

# number of rows
n_rows = matrix.length

# get sum of columns
column_sums = matrix.transpose.map {|x| x.reduce(&:+)}

# most common bit for each column
gamma_rate = column_sums.map {|x| (x > n_rows/2)? 1 : 0}

# least common bit for each column
epsilon_rate = gamma_rate.map {|x| 1 - x}


# convert gamma and epsilon rate from binary to decimal
# conver array containing binary to decimal
def arr_to_dec(arr)
    decimal = 0
    arr.reverse.each_with_index {|b, i| decimal += b * 2**i}
    return decimal
end

gamma_rate = arr_to_dec(gamma_rate)
epsilon_rate = arr_to_dec(epsilon_rate)

power = gamma_rate * epsilon_rate

puts "Power is #{power}"


# part 2

cols = matrix.transpose
rows = matrix


n = n_rows
good_rows_oxygen = Array.new(n_rows, 1)
good_rows_co2 = good_rows_oxygen
for col in cols

    # most common bit
    col_sum = 0
    col.each_with_index {|val, i| col_sum += good_rows[i] * val}
    
    # current bit
    if col_sum >= n/2
        oxygen_bit = 1
        co2_bit = 0
    else
        oxygen_bit = 0
        co2_bit = 1 
    end

    good_rows = col.each_with_index = map {|x| }





