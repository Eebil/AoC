filename = ARGV[0]
input = File.read(filename)

mat = input.split("\n").map(&:chars)

h = mat.size
w = mat[0].size

puts h 
puts w

dirs = [
  [0, 1],   
  [1, 0],   
  [0, -1],  
  [-1, 0],  
  [1, 1],   
  [1, -1],   
  [-1, 1],  
  [-1, -1]  
]

count = 0


def search_xmas?(h,w,mat, x, y, dx, dy)
  word = "XMAS"
  (0...word.length).all? do |i|
    posx, posy = x + i * dx, y + i * dy
    posx.between?(0, h - 1) && posy.between?(0, w - 1) && mat[posx][posy] == word[i]
  end
end

count  = 0

h.times do |i|
  w.times do |j|
    dirs.each do |dx, dy|
      count += 1 if search_xmas?(h,w,mat,i,j,dx,dy)
    end
  end
end

puts count

## part 2

dirs = [
   # remove up down left right from dirs
  [1, 1],   
  [1, -1],   
  [-1, 1],  
  [-1, -1]  
]


def search_mas_midpoints(h,w,mat, x, y, dx, dy)
  word = "MAS"
  midpoint = []
  is_mas = (0...word.length).all? do |i|
    posx, posy = x + i * dx, y + i * dy
    if posx.between?(0, h - 1) && posy.between?(0, w - 1) && mat[posx][posy] == word[i]
      if mat[posx][posy] == "A"
        midpoint = [posx,posy]
      end
      true
    end
  end
  return midpoint if is_mas
end

mas_mids = []
h.times do |i|
  w.times do |j|
    dirs.each do |dx, dy|
      point = search_mas_midpoints(h,w,mat,i,j,dx,dy)
      mas_mids.push(point) if point
    end
  end
end

mas_count =  mas_mids.select{|point| mas_mids.count(point) > 1}.uniq
p mas_count.size