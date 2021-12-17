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

    # hash table of what segements could correspond to what wires
    # initially any segment could correspond to a given wire
    wires_hash = Hash.new(Set[:a, :b, :c, :d, :e, :f, :g])
    # hash table of what pattern lengths (# lit up segments) correspond to what
    # letters
    letter_hash = {
        2 => [:c, :f], # 1
        3 => [:a, :c, :f], # 7
        4 => [:b, :c, :d, :f], # 4
        5 => [:a, :d, :g], # 2, 3, 5
        6 => [:a, :b, :f, :g], # 0, 6, 9
        7 => [:a, :b, :c, :d, :e, :f, :g] # 8
    }

    patterns = signal.split(" ") + output.split(" ")
    patterns.each do |pattern|
        # turn pattern into set of symbols
        pattern = pattern.chars.map(&:to_sym).to_set
        n = pattern.length

        letter_hash[n].each do |wire|
            if wires_hash[wire].length != 1
                wires_hash[wire] &= pattern

                # if we have found the segment, this segment cannot correspond
                # to any other wires
                if wires_hash[wire].length == 1
                    (:a..:g).each do |key|
                        if key != wire
                            wires_hash[key] -= wires_hash[wire]
                        end
                    end
                end
            end

        end
    end

    puts wires_hash
end

# part one
easy_ones = ones + fours + sevens + eights
puts "1, 4, 7, or 8 appear #{easy_ones} times"
