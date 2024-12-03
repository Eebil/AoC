filename = ARGV[0]
input = File.read(filename)

ins = input.scan(/mul\(\d{1,3},\d{1,3}\)/)
sum = 0
ins.each do |ins|
  product = eval(ins.tr("^[0-9,]",'').split(',').join('*'))
  sum += product
end

puts sum




# part 2

enable = true
do_regex = /do\(\)/
dont_regex = /don't\(\)/

ins = input.scan(/do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\)/)

sum = 0

ins.each do |ins|
  case ins
  when do_regex
    enable = true
  when dont_regex
    enable = false
  else
    if enable
      product = eval(ins.tr("^[0-9,]",'').split(',').join('*'))
      sum += product
    end
  end

end

puts sum
