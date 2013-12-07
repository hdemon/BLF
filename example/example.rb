$LOAD_PATH.push('./lib')
require "./lib/blf"

# create the world.
world = World.new width: 500, height: 500

# add a block with coordinates.
world.add_block_with_location start_x: 60, start_y: 0, width: 50, height: 50

(1..50).each do |n|
  w = Random.new(Random.new_seed).rand * 100 + 10
  h = Random.new(Random.new_seed).rand * 100 + 10
  # add a block without coordinates. this becomes a target of allocation.
  world.add_block width: w, height: h
end

# do allocation to all the blocks without coordinates.
world.allocate_all

world.draw
