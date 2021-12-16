# https://adventofcode.com/2021/day/7

require "matrix"

input = File.read("input.txt").split(",").map(&:to_i)

n = input.length
$avg = input.sum/n
$x = Vector.elements(input)
$ones = Vector.elements(Array.new(n, 1))


def score(current)
    diff = $x - current * $ones
    return - diff.map(&:abs).sum
end


# finds minimum of function score (assuming it's convex)
def min(score)
    start = $avg.round
    curr_score = score.call(start)
    above = score.call(start + 1)
    # if score is less than score of one higher, solution is higher, otherwise
    # solution is <= start
    ((above - curr_score) > 0)? step = 1 : step = -1

    curr = start
    next_score = score.call(curr + step)
    while next_score > curr_score
        curr += step
        curr_score = next_score
        next_score = score.call(curr + step)
    end
    fuel = -curr_score
    puts "best position is: #{curr}, with total fuel cost: #{fuel}."
end

# part 1
min(method(:score))

# part 2
def score2(current)
    diff = $x - current * $ones
    fuel = diff.map {|d| (1..d.abs).sum}
    fuel = fuel.sum
    return -fuel
end

min(method(:score2))
