def digit?(char)
  ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].include?(char)
end

def symbol?(char)
  !(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."].include?(char))
end

def symbol_left?(char, row, col, lines)
  found = false
  if col > 0
    found = symbol?(lines[row][col - 1])
    if !found && row > 0
      found = symbol?(lines[row - 1][col - 1])
    end
    if !found && row < lines.length - 1
      found = symbol?(lines[row + 1][col - 1])
    end
  end
  found
end

def symbol_right?(char, row, col, lines)
  found = false
  if col < lines[0].length - 1
    found = symbol?(lines[row][col + 1])
    if !found && row > 0
      found = symbol?(lines[row - 1][col + 1])
    end
    if !found && row < lines.length - 1
      found = symbol?(lines[row + 1][col + 1])
    end
  end
  found
end

def symbol_up_down?(char, row, col, lines)
  found = false
  if row > 0
    found = symbol?(lines[row - 1][col])
  end
  if !found && row < lines.length - 1
    found = symbol?(lines[row + 1][col])
  end
  found
end

def scan_lines(lines)
  length = lines[0].length
  nums_with_adj = []
  lines.each_with_index do |line, row|
    cur_num = ''
    add = false
    line.chars.each_with_index do |char, col|
      if digit?(char)
        cur_num << char
        add = symbol_left?(char, row, col, lines) unless add
        add = symbol_up_down?(char, row, col, lines) unless add
        add = symbol_right?(char, row, col, lines) unless add
      else
        nums_with_adj << cur_num if add
        add = false
        cur_num = ''
      end
    end
    nums_with_adj << cur_num if add && !cur_num.empty?
  end
  nums_with_adj
end

def parse(document)
  scan_lines(document.lines.map {|l| l.strip!})
end

fail unless 4361 ==  parse(DATA.read).map {|str| str.to_i}.sum
puts parse(File.read("input.txt")).map {|str| str.to_i}.sum

__END__
467....467
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
