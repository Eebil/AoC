filename = ARGV[0]
input = File.read(filename)

grid = input.split("\n").map(&:chars)


h = grid.size
w = grid[0].size
nodes = Hash.new()

# scan the map and record position of each antenna
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if cell.match(/[a-zA-Z0-9]/)
      nodes[cell] ||= []
      nodes[cell] << [x, y]
    end
  end
end

antinode_count = 0
antinode_arr = []

# scan the nodes and calculate the antinodes
nodes.each do |key, antenna_positions|
  antenna_positions.each_with_index do |antenna_position, i|
    (i+1...antenna_positions.size).each do |j|
      other_antenna_position = antenna_positions[j]
      dx = other_antenna_position[0] - antenna_position[0]
      dy = other_antenna_position[1] - antenna_position[1]
      # calculate bot antinode positios for the pair of antennas
      antinode_position_1 = [other_antenna_position[0] + dx, other_antenna_position[1] + dy]
      antinode_position_2 = [antenna_position[0] - dx, antenna_position[1] - dy]

      # check if the antinode is within the grid
      if antinode_position_1[0].between?(0, w-1) && antinode_position_1[1].between?(0, h-1)
        antinode_arr.push(antinode_position_1)
        antinode_count += 1
      end
      if antinode_position_2[0].between?(0, w-1) && antinode_position_2[1].between?(0, h-1)
        antinode_arr.push(antinode_position_2)
        antinode_count += 1
      end
    end
  end
end

p antinode_count
p antinode_arr.uniq.size  

# Part 2

antinode_count = 0
antinode_arr = []

# scan the nodes and calculate the antinodes
nodes.each do |key, antenna_positions|
  antenna_positions.each_with_index do |antenna_position, i|
    (i+1...antenna_positions.size).each do |j|
      other_antenna_position = antenna_positions[j]
      dx = other_antenna_position[0] - antenna_position[0]
      dy = other_antenna_position[1] - antenna_position[1]
      # calculate bot antinode positios for the pair of antennas
      # for part two antinodes occur at the antenna position + every multiple of the dx, dy vector bound by the grid
      d_mult = 0
      # I CBA to craft the condition :D, ugly ass hack, but works
      h.times do
        antinode_position_1 = [other_antenna_position[0] + dx*d_mult, other_antenna_position[1] + dy*d_mult]
        antinode_position_2 = [antenna_position[0] - dx*d_mult, antenna_position[1] - dy*d_mult]

        if antinode_position_1[0].between?(0, w-1) && antinode_position_1[1].between?(0, h-1)
          antinode_arr.push(antinode_position_1)
          antinode_count += 1
        end
        if antinode_position_2[0].between?(0, w-1) && antinode_position_2[1].between?(0, h-1)
          antinode_arr.push(antinode_position_2)
          antinode_count += 1
        end
        d_mult += 1
      end
    end
  end
end

puts "part 2"
p antinode_count
p antinode_arr.uniq.size

