# https://adventofcode.com/2021/day/05



input = File.open("input.txt")

lines = input.readlines

$map = [[]]

# reorganise into [ [[start], [end]], [...], ...]
lines = lines.map {|x| x.chomp.split(' -> ').map {|y| y.split(",")}}

def add_point(coord)
    x, y = coord

    # if coord doesn't exist yet on map
    if !($map[y])
        $map[y] = []
    end

    if !($map[y][x])
        $map[y][x] = 1
    else
        $map[y][x] += 1
    end
end

# return "0" if x is nil else x.to_s
def get_char(x)
    (x)? x.to_s : "."
end

def draw_map
    for line in $map do
        if line
            puts line.reduce {|a, b| get_char(a) + get_char(b)}
        else
            puts "."
        end
    end
    puts ""
end

lines.each do |start, stop|
    start = start.map &:to_i
    stop = stop.map &:to_i

    dx = stop[0] - start[0]
    dx = (dx == 0)? 0 : dx/dx.abs
    dy = stop[1] - start[1]
    dy = (dy == 0)? 0 : dy/dy.abs

    # if dx != 0 && dy != 0
    #     next
    # end

    x_done = false
    y_done = false
    while true
        add_point(start)

        if start[0] != stop[0]
            start[0] += dx
        else
            x_done = true
        end

        if start[1] != stop[1]
            start[1] += dy
        else
            y_done = true
        end

        if x_done && y_done
            break
        end
    end

end

overlap_counter = 0

$map.each do |row|
    if row
        row.each do |x|
            if x && x > 1
                overlap_counter += 1
            end
        end
    end
end

puts overlap_counter
