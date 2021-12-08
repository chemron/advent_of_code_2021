# https://adventofcode.com/2021/day/3
require "matrix"

input = File.open("input.txt")

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
cols = cols.map {|col| Vector.elements(col)}
rows = matrix




n = n_rows

# rows that satisfy bit criteria (initially all rows do)
ones_vector = Vector.elements(Array.new(n_rows, 1))
valid_rows_oxygen = ones_vector
valid_rows_co2 = ones_vector


# sum over the good rows in a single column
def get_sum(col, good_rows)
    col_sum = 0
    col.each_with_index {|val, i| col_sum += good_rows[i] * val}
    return col_sum
end



for col in cols
    # most common bit
    n = valid_rows_oxygen.sum
    if n > 1
        col_sum = get_sum(col, valid_rows_oxygen)


        if col_sum >= n/2.0
            #  this means the good bit is 1, and the good rows are the ones with
            #  1 in them
            valid_rows_oxygen = Matrix.diagonal(*valid_rows_oxygen) * col

        else
            #  this means the good bit is 0, and the good rows are the ones with
            #  1 in them
            valid_rows_oxygen = Matrix.diagonal(*valid_rows_oxygen) * (ones_vector - col)
        end

        # if the good bit is 1, the good rows are the ones with 1 in them

    end

    n = valid_rows_co2.sum
    if n > 1
        col_sum = get_sum(col, valid_rows_co2)


        if col_sum < n/2.0
            #  this means the good bit is 1, and the good rows are the ones with
            #  1 in them
            valid_rows_co2 = Matrix.diagonal(*valid_rows_co2) * col

        else
            #  this means the good bit is 0, and the good rows are the ones with
            #  1 in them
            valid_rows_co2 = Matrix.diagonal(*valid_rows_co2) * (ones_vector - col)
        end

        # if the good bit is 1, the good rows are the ones with 1 in them

    end
end

# index of c02 rating
co2_i = 0
o2_i = 0
valid_rows_co2.each_with_index {|x, i| (x == 1)? co2_i=i : nil}
valid_rows_oxygen.each_with_index {|x, i| (x == 1)? o2_i=i : nil}

oxygen_rating = arr_to_dec(rows[o2_i])

co2_rating = arr_to_dec(rows[co2_i])

puts oxygen_rating * co2_rating


