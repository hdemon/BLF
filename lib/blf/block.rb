class Block
  def initialize(args)
    @start_x = args[:start_x]
    @start_y = args[:start_y]
    @width = args[:width]
    @height = args[:height]
    @end_x = @start_x + @width
    @end_y = @start_y + @height
    @world = args[:world]
  end

  def draw
    dr = Draw.new
    dr.stroke = "#ccddff"
    dr.stroke_width 1
    dr.rectangle @start_x, @start_y, @end_x, @end_y
    dr.draw @world.image
  end
end
