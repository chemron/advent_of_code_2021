require 'set'

# https://adventofcode.com/2021/day/8

# key:
#  aaaaa
# b     c
# b     c
#  ddddd
# e     f
# e     f
#  ggggg


input = File.open("test_input2.txt")
lines = input.readlines

lines.map! {|line| line.split(" | ")}

ones = 0
fours = 0
sevens = 0
eights = 0
lines.each do |signal, output|
    # set of possible options
    a = b = c = d = e = f = g = Set['a', 'b', 'c', 'd', 'e', 'f', 'g']

    patterns = signal.split(" ") + output.split(" ")
    patterns.each do |pattern|
        pattern = pattern.chars.to_set
        n = pattern.length

        case n
        when 2
            # must be a 1 (c and f)
            ones += 1
            c &= pattern
            f &= pattern
        when 3
            # must be a 7 (a, c and f)
            sevens += 1
            a &= pattern
            c &= pattern
            f &= pattern
        when 4
            # must be a 4 (b, c, d and f)
            fours += 1
            b &= pattern
            c &= pattern
            d &= pattern
            f &= pattern
        when 5
            # must be a 2, 3 or 5 (all use a, d and g)
            a &= pattern
            d &= pattern
            g &= pattern
        when 6
            # must be a 0, 6 or 9 (all use a, b, d, f and g)
            a &= pattern
            b &= pattern
            d &= pattern
            f &= pattern
            g &= pattern
        when 7
            # must be an 8
            eights += 1
        else
            print "Must be an error"
        end
    end

    puts a
    puts b
    puts c
    puts d
    puts e
    puts f
    puts g
end

# part one
easy_ones = ones + fours + sevens + eights
puts "1, 4, 7, or 8 appear #{easy_ones} times"
