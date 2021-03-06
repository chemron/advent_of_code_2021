# https://adventofcode.com/2021/day/02


input = File.open("input.txt")

instructions = input.readlines.map {|x| x.chomp.split(" ")}

vertical_distance = 0
horizontal_distance = 0

instructions.each do |direction, value|
    value = value.to_i
    if direction=="forward"
        horizontal_distance += value
    elsif direction == "up"
        vertical_distance -= value
    elsif direction == "down"
        vertical_distance += value
    else
        puts "error, direction is #{direction}"
    end
end

puts vertical_distance * horizontal_distance
