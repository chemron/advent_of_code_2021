# https://adventofcode.com/2021/day/6

input = File.read("input.txt").split(",").map(&:to_i)

# initial state
# state[time] = # of fish with timer = time
current_state = Array.new(9, 0)
input.each {|time| current_state[time] += 1 }


def next_state(current_state)
    next_state = Array.new(9, 0)
    current_state.each_with_index do |n_fish, time|
        if time == 0
            # fish been born
            next_state[8] += n_fish
            # fish reseting timmer
            next_state[6] += n_fish
        else
            next_state[time - 1] += n_fish
        end
    end
    return next_state
end


update = Proc.new {current_state = next_state(current_state)}
# run 80 times
80.times &update
n_fish = current_state.sum
puts "After 80 days, there are #{n_fish} fish"

# run 256 times
(256 - 80).times &update
n_fish = current_state.sum
puts "After 256 days, there are #{n_fish} fish"
