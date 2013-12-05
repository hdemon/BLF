require "lib/blf"

world = World.new(500, 500)

# world.add_initial_block
(1..30).each do |i|
  world.add_block width: random(10, 30), height: random(10, 30)
end

world.draw_up_blocks

def random(min, max)
  Random.new(Random.new_seed) * (max - min) + min
end
