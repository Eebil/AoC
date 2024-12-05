filename = ARGV[0]
input = File.read(filename)

rules,mans = input.split("\n\n")


rules = rules.split.map{_1.split('|').map &:to_i}
mans = mans.split.map{_1.split(',').map &:to_i}


valid = mans.select{|man|
  man.combination(2).all?{|comb|
    rules.all?{|rule|
      comb.reverse != rule
    }
  }
}

puts valid.map{_1[_1.size/2]}.sum


## part 2

def generate_sort_order(rules)
  graph = Hash.new { |h, k| h[k] = [] }
  in_degree = Hash.new(0)

  rules.each do |before, after|
    graph[before] << after
    in_degree[after] += 1
    in_degree[before] ||= 0
  end

  queue = graph.keys.select { |node| in_degree[node] == 0 }
  sorted = []

  while queue.any?
    node = queue.shift
    sorted << node

    graph[node].each do |neighbor|
      in_degree[neighbor] -= 1
      queue << neighbor if in_degree[neighbor] == 0
    end
  end

  if sorted.size != graph.keys.size
    raise "conflicting rules."
  end

  sorted
end

invalid = mans.reject{|man|
  man.combination(2).all?{|comb|
    rules.all?{|rule|
      comb.reverse != rule
    }
  }
}

p invalid


corrected = invalid.map { |man|
  narrowed_rules = rules.select { |rule| man.include?(rule[0]) && man.include?(rule[1]) }
  order = generate_sort_order(narrowed_rules)
  man.sort_by{|n| order.index(n)}
}

p corrected

puts corrected.map{_1[_1.size/2]}.sum