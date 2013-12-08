require "blf/version"
require "blf/world"
require "blf/block"

module BLF
  def self.create_world(args)
    BLF::World.new width: args[:width], height: args[:height]
  end
end
