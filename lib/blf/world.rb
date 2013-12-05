require 'rmagick'
include Magick

class World
  attr_reader :width, :height, :blocks, :image, :bl_stable_point_list

  def initialize(args)
    @width = args[:width]
    @height = args[:height]
    @blocks = []
    @bl_stable_point_list = []
  end

  def add_block(args)
    @blocks << Block.new(width: args[:width], height: args[:height], world: self)
  end

  def add_block_with_location(args)
    @blocks << Block.new(start_x: args[:start_x], start_y: args[:start_y], 
                         width: args[:width], height: args[:height], world: self)
  end

  def add_bl_stable_point_candidates(current_block)
    # 母材の端
    @bl_stable_point_list << { x: 0, y: current_block.start_y }
    @bl_stable_point_list << { x: current_block.start_x, y: 0 }

    @blocks.each do |existing_block|
      @bl_stable_point_list << case
      when (existing_block.end_x <= current_block.start_x) && (existing_block.end_y > current_block.end_y)
        { x: existing_block.end_x, y: current_block.end_y }
      when (existing_block.end_x >= current_block.start_x) && (existing_block.end_y < current_block.end_y)
        { x: current_block.end_x, y: existing_block.end_y }
      when (existing_block.end_x > current_block.end_x) && (existing_block.end_y <= current_block.start_y)
        { x: current_block.end_x, y: existing_block.end_y }
      when (existing_block.end_x < current_block.end_x) && (existing_block.start_y > current_block.end_y)
        { x: existing_block.end_x, y: current_block.end_y }
      end
    end

    @bl_stable_point_list.compact
  end

  def draw
    @image = Image.new(@width, @height) do
     self.background_color = 'white'
    end

    @blocks.each {|block| block.draw }
    @image.write("example.jpg")
  end
end
