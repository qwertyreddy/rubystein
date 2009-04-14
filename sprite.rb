require 'weapon'

module Sprite
  TEX_WIDTH  = 64
  TEX_HEIGHT = 64
  
  attr_accessor :x
  attr_accessor :y
  attr_accessor :window
  attr_accessor :slices
end

class SpritePool
  @@files = {}
  
  def self.get(window, file_path, sprite_height)
    file_path = File.expand_path(file_path)
    if !@@files[file_path]
      @@files[file_path] = Gosu::Image::load_tiles(window, file_path, 1, Sprite::TEX_HEIGHT, true)
    end
    
    return @@files[file_path]
  end
end

class Lamp
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'lamp.bmp', TEX_HEIGHT)
  end
end

