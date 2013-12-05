$LOAD_PATH.push('./lib')
require "./lib/blf"

world = World.new width: 500, height: 500
world.add_block start_x: 0, start_y: 0, width: 50, height: 50
world.draw
