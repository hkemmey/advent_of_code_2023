
def calc_power(draws_str)
  mins = {"blue" => nil, "green" => nil, "red" => nil}
  draws_str.split("; ").each do |draw|
    draw.split(", ").each do |cubes|
      num, color = cubes.scan(/(\d+)\s(red|green|blue)/).flatten
      mins[color] = num.to_i if mins[color].nil? || mins[color] < num.to_i
    end
  end
  mins["red"] * mins["blue"] * mins["green"]
end

def parse(document)
  powers = []
  document.lines.each do |line|
    game, draws = line.split(": ")
    id = game.scan(/\d+/).flatten.first.to_i

    powers << calc_power(draws)
  end
  powers
end

fail unless 2286 == parse(DATA.read).sum
puts parse(File.read("input.txt")).sum

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
