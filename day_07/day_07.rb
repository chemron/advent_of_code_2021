# https://adventofcode.com/2021/day/7

require "matrix"

input = File.read("input.txt").split(",").map(&:to_i)

n = input.length
avg = input.sum/n

$x = Vector.elements(input)
$ones = Vector.elements(Array.new(n, 1))


def score(current)
    diff = $x - current * $ones
    return - diff.map(&:abs).sum
end

start = avg.round
curr_score = score(start)
above = score(start + 1)
# if score is less than score of one higher, solution is higher, otherwise
# solution is <= start
((above - curr_score) > 0)? step = 1 : step = -1

curr = start
next_score = score(curr + step)
while next_score > curr_score
    curr += step
    curr_score = next_score
    next_score = score(curr + step)
end

fuel = -curr_score
puts "best position is: #{curr}, with total fuel cost: #{fuel}."
