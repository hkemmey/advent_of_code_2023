
$digit_map = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3,
  '4' => 4, '5' => 5, '6' => 6, '7' => 7,
  '8' => 8, '9' => 9, 'zero' => 0, 'one' => 1,
  'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5,
  'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9
}

def calibration(line)
    /^\D*(?<first>\d).*\D*(?<last>\d)\D*|(?<first>\d)/ =~ line

    return "#{first}#{last}".to_i if first != nil && last != nil
    return "#{first}#{first}".to_i if first != nil
    return 0
end

def calibrateTwo(line)
  substr = ''
  keys = $digit_map.keys()
  first = last = nil
  chars = line.split("")
  chars.each do |c|
    substr << c
    keys.each do |key|
      if substr.include?(key)
        first = $digit_map[key] if first == nil
        last = $digit_map[key] if first != nil
        substr = ''

        if $digit_map[c] == nil
          substr = c #walk back in case like 'eightwo' should be two not eight
        end
      end
    end
  end

  return "#{first}#{last}".to_i if first != nil && last != nil
  return "#{first}#{first}".to_i if first != nil
  return 0
end

input = File.open("input.txt", "r")

sum = 0
sum2 = 0
input.each do |line|
  sum += calibration(line)
  sum2 += calibrateTwo(line.strip)
end
puts sum
puts sum2
