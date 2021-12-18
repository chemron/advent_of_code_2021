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
                update_segments(wire)
            end
        end
    end
end


# if we have found the segment corresponding to wire, this segment cannot correspond
# to any other wires
def update_segments(wire)
    (:a..:g).each do |key|
        if (key != wire) & (@segment_hash[key].length != 1)
            @segment_hash[key] -= @segment_hash[wire]

            (@segment_hash[key].length == 1)? update_segments(key) : nil

        end
    end
end


# decode pattern with the segment hash
def decode_pattern(pattern)
    segments = pattern.chars.map {|wire| @segment_hash_inverse[wire.to_sym]}
    segments = segments.to_set

    if segments == Set[:c, :f]
        @ones += 1
        return 1
    elsif segments == Set[:a, :c, :d, :e, :g]
        return 2
    elsif segments ==  Set[:a, :c, :d, :f, :g]
        return 3
    elsif segments ==  Set[:b, :c, :d, :f]
        @fours += 1
        return 4
    elsif segments ==  Set[:a, :b, :d, :f, :g]
        return 5
    elsif segments ==  Set[:a, :b, :d, :e, :f, :g]
        return 6
    elsif segments ==  Set[:a, :c, :f]
        @sevens += 1
        return 7
    elsif segments ==  Set[:a, :b, :c, :d, :e, :f, :g]
        @eights += 1
        return 8
    elsif segments ==  Set[:a, :b, :c, :d, :f, :g]
        return 9
    elsif segments ==  Set[:a, :b, :c, :e, :f, :g]
        return 0
    else
        puts @segment_hash_inverse
        puts segments
        puts "Error!"
        return "nah man"
    end
end


input = File.open("input.txt")
lines = input.readlines

lines.map! {|line| line.split(" | ")}


@ones = 0
@fours = 0
@sevens = 0
@eights = 0
@output_total = 0

lines.each do |signal, output|

    # hash table of what segments could correspond to what wires
    # initially any segment could correspond to a given wire
    @segment_hash = Hash.new(Set[:a, :b, :c, :d, :e, :f, :g])

    output_patterns = output.split(" ")
    signal_patterns = signal.split(" ")

    # find corresponding segments for each wire
    patterns = signal_patterns + output_patterns
    patterns.each {|pattern| get_segments(pattern)}

    # replace sets with symbols
    @segment_hash.each do |wire, segment|
        if segment.length != 1
            puts "Error, with wire: #{wire}, multiple segments: #{segment}"
        end
        @segment_hash[wire] = segment.to_a[0]
    end

    # inverse of the segment hash
    @segment_hash_inverse = @segment_hash.invert
    output_values = output_patterns.map {|pattern| decode_pattern(pattern)}
    output_value = output_values.join("").to_i
    @output_total += output_value
end


# part one
easy_ones = @ones + @fours + @sevens + @eights
puts "1, 4, 7, or 8 appear #{easy_ones} times"

# part two
puts "Total output sum is: #{@output_total}"
