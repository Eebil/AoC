filename = ARGV[0]
input = File.read(filename)

reports = input.split("\n")

safe_count = 0

reports.each do |report|
  levels = report.split.map &:to_i
  safe = true
  prev = levels[0] 
  dec = levels[0] - levels[-1] > 0
  (levels.size-1).times do |i|
    if (dec)
      safe = false unless ((prev - levels[i+1]) > 0 && (prev - levels[i+1]) < 4)
      prev = levels[i+1]
    else
      safe = false unless ((prev - levels[i+1]) < 0 && (-4 < prev - levels[i+1]))
      prev = levels[i+1]
    end
  end
  safe_count += 1 if safe
end


puts "Safe reports: #{safe_count}"

### apply problem dampener for part 2 ###

safe_count_pd = 0

def is_safe?(levels)
  dec = levels[0] - levels[-1] > 0
  levels.each_cons(2).all? do |a, b|
    diff = a-b 
    if dec
      diff > 0 && diff < 4
    else
      diff < 0 && diff > -4
    end
  end
end

def check_safeness_with_problem_dampener(levels)

  # Check without pd
  return 1 if is_safe?(levels)

  # Check if removing a single level makes the sequence safe
  levels.each_with_index do |_, idx|
    modified_levels = levels[0...idx] + levels[idx+1..]
    return 1 if is_safe?(modified_levels)
  end
  0
end

reports.each do |report|
  levels = report.split.map &:to_i
  safe_count_pd += check_safeness_with_problem_dampener(levels)
end

puts "Safe with PD: #{safe_count_pd}"

