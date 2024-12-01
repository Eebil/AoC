filename = ARGV[0]
input = File.read(filename)

rows = input.split("\n")
col1,col2 = [], []

rows.each do |row|
  a,b = row.split.map &:to_i
  col1.push(a)
  col2.push(b)
end

col1 = col1.sort 
col2 = col2.sort 

sum = 0

rows.length.times do |i|
  sum += (col1[i] - col2[i]).abs
end

puts "sum of diffs"
puts sum


sim_score = 0

puts "part 2 similarity score"
sim_score = col1.map {|num|
  num * col2.count(num)
}.sum

puts sim_score


