filename = ARGV[0]
input = File.read(filename)

lines = input.split("\n")

t_vals = lines.map{_1.split(':')[0].to_i} 
equations = lines.map{_1.split(':')[1].split.map(&:to_i)}

sum = 0


# Part 2 was just to add the operation here and new case to the switch
ops = ['+','*','|']

equations.each.with_index do |equation, i|

  combinations = ops.repeated_permutation(equation.size - 1).to_a

  combinations.each do |operators|

    value = equation[0]
    operators.each.with_index do |op, j|
      case op
      when '+'
        value += equation[j+1]
      when '*'
        value *= equation[j+1]
      when '|'
        value = (value.to_s + equation[j+1].to_s).to_i
      end
    end
    if value == t_vals[i]
      sum += t_vals[i]
      break
    end
  end
end

puts sum

