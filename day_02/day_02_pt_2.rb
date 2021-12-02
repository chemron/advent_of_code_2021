# https://adventofcode.com/2021/day/02


input = File.open("input.txt")

instructions = input.readlines.map {|x| x.chomp.split(" ")}

depth = 0
horizontal_distance = 0
aim = 0

instructions.each do |direction, value|
    value = value.to_i
    if direction=="forward"
        horizontal_distance += value
        depth += aim * value
    elsif direction == "up"
        aim -= value
    elsif direction == "down"
        aim += value
    else
        puts "error, direction is #{direction}"
    end
end

puts depth * horizontal_distance
