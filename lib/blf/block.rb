require "active_support/all"

class Block
  attr_accessor :start_x, :start_y, :width, :height, :end_x, :end_y, :world

  def initialize(args)
    @start_x = args[:start_x] || 0
    @start_y = args[:start_y] || 0
    @width = args[:width] || 0
    @height = args[:height] || 0
    @world = args[:world]
  end

  def end_x
    (@start_x + @width).presence || 0
  end

  def end_y
    (@start_y + @height).presence || 0
  end

  def draw
    dr = Draw.new
    dr.stroke = "#ccddff"
    dr.fill = "rgb(#{random*255}, #{random*255}, #{random*255})"
    dr.stroke_width 1
    dr.rectangle @start_x, @start_y, end_x, end_y
    dr.draw @world.image
  end

  def random
    Random.new(Random.new_seed).rand
  end
end
