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

# hash table of what pattern lengths (# lit up segments) correspond to what
# letters
@wire_hash = {
    2 => [:c, :f], # 1
    3 => [:a, :c, :f], # 7
    4 => [:b, :c, :d, :f], # 4
    5 => [:a, :d, :g], # 2, 3, 5
    6 => [:a, :b, :f, :g], # 0, 6, 9
    7 => [:a, :b, :c, :d, :e, :f, :g] # 8
}


# for a given pattern, update wire hash with available information
def get_segments(pattern)
    # turn pattern into set of symbols
    pattern = pattern.chars.map(&:to_sym).to_set
    n = pattern.length

    # itterate through wires that must correspond to the pattern
    @wire_hash[n].each do |wire|
        if @segment_hash[wire].length != 1

            # correct segment for given wire must be a subset of the pattern
            @segment_hash[wire] &= pattern

            # if we have found the segment for the given wire, this segment cannot correspond
            # to any other wires
            if @segment_hash[wire].length == 1
                update_segements(wire)
            end
        end
    end
end


# if we have found the segment corresponding to wire, this segment cannot correspond
# to any other wires
def update_segements(wire)
    (:a..:g).each do |key|
        if (key != wire) & (@segment_hash[key].length != 1)
            @segment_hash[key] -= @segment_hash[wire]

            (@segment_hash[key].length == 1)? update_segements(key) : nil

        end
    end
end



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
    @segment_hash = Hash.new(Set[:a, :b, :c, :d, :e, :f, :g])

    patterns = signal.split(" ") + output.split(" ")
    patterns.each do |pattern|
        get_segments(pattern)
    end

    
    puts @segment_hash
end


# part one
easy_ones = ones + fours + sevens + eights
puts "1, 4, 7, or 8 appear #{easy_ones} times"
