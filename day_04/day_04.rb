# https://adventofcode.com/2021/day/04
require 'set'

input = File.read("input.txt")

input = input.split("\n\n")

numbers = input[0].chomp.split(",").map(&:to_i)
boards = input[1...]


class Bingo
    attr_reader :boards, :board_map, :done, :score
    # takes a list of board strings
    def initialize(board_strs)
      str_to_boards(board_strs)
      @done = []
      @score = []
      build_map
    end

    # converts a list of board strings into a list of board arrays
    def str_to_boards(board_strs)
        @boards = board_strs.map do |board_str|
            rows = board_str.split("\n")
            # convert each row to a list of ints
            rows.map! {|row| row.split(" ").map(&:to_i)}

            rows
        end
    end

    # build a map where  @board_map[num] returns a set where each element is a list [i_b, i_r,
    # i_c], i.e. the board row and column indexes where num occurs
    def build_map
        @board_map = Hash.new {|hash, key| hash[key] = Set.new}

        @boards.each_with_index do |board, i_b|
            board.each_with_index do |row, i_r|
                row.each_with_index do |val, i_c|
                    @board_map[val] << [i_b, i_r, i_c]
                end
            end
        end
    end

    # next bingo number
    def next(num)
        indices = @board_map[num]
        indices.each do |i_b, i_r, i_c|
            @boards[i_b][i_r][i_c] = nil
            check_if_done(i_b, i_r, i_c, num)
        end
    end

    # for given board row and column, check if game is one
    def check_if_done(i_b, i_r, i_c, num)
        # check if board was already done
        (@done.include? i_b)? return : nil

        row = @boards[i_b][i_r]
        col = @boards[i_b].transpose[i_c]

        if row.all?(&:nil?) || (col.all?(&:nil?))
            board = @boards[i_b]
            board_sum = board.flatten.compact.sum
            @done << i_b
            @score << board_sum * num
        end

    end

    def to_s
        s = ""
        @boards.each {|rows| s += board_to_s(rows)}

        return s
    end

    def board_to_s(rows)
        s = ""
        rows.each do |row|
            s += row_to_s(row)
        end
        s += "\n"

        return s
    end


    private
    def row_to_s(row)
        str = row.map do |val|
            case val
            when nil
                " X"
            when 0..9
                " #{val}"
            else
                val.to_s
            end
        end
        return str.join(" ") + "\n"
    end


end

game = Bingo.new(boards)

# part 1
pt_1_done = false
numbers.each do |num|
    game.next(num)
    puts game
    puts "---"
    if game.done.length != 0 && !pt_1_done
        puts "Our winner is board(s) #{game.done.join(", ")} with score(s) #{game.score.join(", ")}"
        pt_1_done = true
    end
end

# part 2
puts "Our loser is board #{game.done[-1]} with score(s) #{game.score[-1]}"

