$LOAD_PATH.push('./lib')
require "./lib/blf"

world = World.new width: 500, height: 500
world.add_block_with_location start_x: 0, start_y: 0, width: 50, height: 50
# world.add_block width: 25, height: 50
world.draw
