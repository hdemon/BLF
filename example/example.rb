require "blf"

# create the world.
world = BLF.create_world width: 500, height: 500

# add a block with coordinates.
world.add_block_with_location x: 60, y: 0, width: 50, height: 50

(1..50).each do |n|
  w = Random.new(Random.new_seed).rand * 100 + 10
  h = Random.new(Random.new_seed).rand * 100 + 10
  # add a block without coordinates. this becomes a target of allocation.
  world.add_block width: w, height: h
end

# do allocation to all the blocks without coordinates.
world.allocate_all

world.draw
