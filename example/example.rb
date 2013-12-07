$LOAD_PATH.push('./lib')
require "./lib/blf"

world = World.new width: 500, height: 500

# 座標を指定してブロックを追加する。
world.add_block_with_location start_x: 60, start_y: 0, width: 50, height: 50

(1..50).each do |n|
  w = Random.new(Random.new_seed).rand * 100 + 10
  h = Random.new(Random.new_seed).rand * 100 + 10
  # 座標を指定せずにブロックを追加し、詰め込みの対象とする。
  world.add_block width: w, height: h
end

world.allocate_all
world.draw
