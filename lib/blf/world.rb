require 'rmagick'
include Magick

module BLF
  class World
    attr_reader :width, :height, :blocks, :image, :bl_stable_point_list, :unplaced_blocks, :placed_blocks

    def initialize(args)
      @width = args[:width]
      @height = args[:height]
      @unplaced_blocks = []
      @placed_blocks = []
      @bl_stable_point_list = []
    end

    def add_block(args)
      @unplaced_blocks << Block.new(width: args[:width], height: args[:height], world: self)
    end

    def add_block_with_location(args)
      @placed_blocks << Block.new(start_x: args[:x], start_y: args[:y], width: args[:width], height: args[:height], world: self)
    end

    def add_bl_stable_point_candidates(new_block)
      @bl_stable_point_list << { x: new_block.end_x, y: 0, width: 0, height: new_block.start_y }
      @bl_stable_point_list << { x: 0, y: new_block.end_y, width: new_block.start_x, height: 0 }

      @placed_blocks.each_with_index do |placed_block, index|
        if (placed_block.end_x <= new_block.start_x) && (placed_block.end_y > new_block.end_y)
          @bl_stable_point_list << { x: placed_block.end_x, y: new_block.end_y, width: new_block.start_x - placed_block.end_x, height: placed_block.start_y - new_block.end_y }

        elsif (new_block.end_x <= placed_block.start_x) && (new_block.end_y > placed_block.end_y)
          @bl_stable_point_list << { x: new_block.end_x, y: placed_block.end_y, width: placed_block.start_x - new_block.end_x, height: new_block.start_y - placed_block.end_y }

        elsif (new_block.end_x < placed_block.end_x) && (placed_block.end_y <= new_block.start_y)
          @bl_stable_point_list << { x: new_block.end_x, y: placed_block.end_y, width: placed_block.start_x - new_block.end_x, height: new_block.start_y - placed_block.end_y }

        elsif (placed_block.end_x < new_block.end_x) && (new_block.end_y <= placed_block.start_y)
          @bl_stable_point_list << { x: placed_block.end_x, y: new_block.end_y, width: new_block.start_x - placed_block.end_x, height: placed_block.start_y - new_block.end_x }

        end
      end
    end

    def allocate new_block
      @bl_stable_point_list.each do |point|
        if stable? point, new_block
          unless overlapped?(start_x: point[:x], start_y: point[:y], width: new_block.width, height: new_block.height) ||
                 beyond_area?(start_x: point[:x], start_y: point[:y], width: new_block.width, height: new_block.height)
            new_block.start_x = point[:x]
            new_block.start_y = point[:y]
            @placed_blocks << new_block
            break
          end
        end
      end
    end

    def allocate_all
      # 左上端をブロックの組み合わせごとに追加するのは無駄なので、ここで一回だけ追加する。
      @bl_stable_point_list << { x: 0, y: 0, width: 0, height: 0 }

      @unplaced_blocks.length.times do
        # BL候補点の配列の順番通りに配置を試すので、Bottom-Leftの規則に沿って、yが少ない順に並べ替える。
        @bl_stable_point_list.sort! {|a, b| a[:y] <=> b[:y] }

        block = @unplaced_blocks.shift
        allocate block
        add_bl_stable_point_candidates block
        self.draw
      end
    end

    def stable?(point, current_block)
      if point[:width] <= 0
        current_block.height >= point[:height]
      elsif point[:height] <= 0
        current_block.width >= point[:width]
      else
        current_block.width >= point[:width] && current_block.height >= point[:height]
      end
    end

    def overlapped?(args)
      start_x = args[:start_x]
      start_y = args[:start_y]
      end_x = args[:start_x] + args[:width]
      end_y = args[:start_y] + args[:height]

      @placed_blocks.map do |block|
        block.start_x < end_x &&
        block.start_y < end_y &&
        start_x < block.end_x &&
        start_y < block.end_y
      end.any?
    end

    def beyond_area?(args)
      end_x = args[:start_x] + args[:width]
      end_y = args[:start_y] + args[:height]
      !(end_x <= self.width && end_y <= self.height)
    end

    def draw
      @image = Image.new(@width, @height) do
       self.background_color = 'white'
      end

      # draw placed blocks
      @placed_blocks.each {|block| block.draw }

      # draw bl stable points
      @bl_stable_point_list.compact.each do |point|
        dr = Draw.new
        dr.fill = "black"
        dr.ellipse(point[:x], point[:y], 1, 1, 0, 360)
        dr.draw @image
      end

      @image.write("example.jpg")
    end
  end
end
