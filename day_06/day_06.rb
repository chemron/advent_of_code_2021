# https://adventofcode.com/2021/day/6

input = File.read("test_input.txt")
initial_state = input.split(",").map(&:to_i)

def next_state(current_state)
    new_fish = 0
    next_state = current_state.map do |timer|
        if timer == 0
            new_fish += 1
            6
        else
            timer - 1
        end
    end
    next_state += Array.new(new_fish, 8)
    return next_state
end

inificient

puts next_state(next_state(initial_state))
