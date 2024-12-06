filename = ARGV[0]
input = File.read(filename)

grid = input.split("\n").map(&:chars)



h = grid.size
w = grid[0].size

guard = ['^','>','v','<']
dx = [[-1,0],[0,1],[1,0],[0,-1]]
idx = 0

gp = []
stuff = []
visited = []

h.times do |i|
  w.times do |j|
    if guard.include?(grid[i][j])
      gp = [i,j]
      visited.push([i,j])
      idx = guard.index(grid[i][j])
    end
    stuff.push([i,j]) if grid[i][j] == '#' 
  end
end

# save original initial vars for part 2
original_gp = gp 
original_idx = idx


while gp[0].between?(0,(h-1)) && gp[1].between?(0,(w-1))
  dir = dx[idx]
  next_pos = [gp[0]+dir[0] , gp[1]+dir[1]]
  if stuff.include?(next_pos)
    idx = (idx+1) % 4
    puts "obstacle"
  else
    gp = next_pos
    visited.push(gp)
  end
end 


puts visited.uniq.count - 1


# part 2


# Gets the job done, but really unoptimized, takes +30 mins to run. Consider optimizing this.

puts "part 2"

original_visited = visited.uniq[1..]
loops = 0

places_to_check = original_visited.size
iterations = 0

original_visited.each do |pos|

  gp = original_gp.dup
  idx = original_idx
  visited = Hash.new(0)
  stuff_copy = stuff.dup
  stuff_copy.push(pos)

  puts "checking place: #{iterations}/#{places_to_check}"
  iterations += 1

  while gp[0].between?(0,(h-1)) && gp[1].between?(0,(w-1))
    dir = dx[idx]
    next_pos = [gp[0]+dir[0] , gp[1]+dir[1]]
    if stuff_copy.include?(next_pos)
      idx = (idx+1) % 4
    else
      gp = next_pos
      visited[gp] += 1
      if visited[gp] > 4
        puts "loop detected"
        loops += 1
        break
      end
    end
  end 

end

puts loops


  