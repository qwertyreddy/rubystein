module Sprite
  TEX_WIDTH  = 64
  TEX_HEIGHT = 64
  
  attr_accessor :x
  attr_accessor :y
  attr_reader :slices

  def initialize(window, tex_path, x = 0, y = 0)
    @x = x
    @y = y
    @slices = Gosu::Image::load_tiles(window, tex_path, 1, TEX_HEIGHT, true)
  end
end

class Lamp
  include Sprite
  
  def initialize(window, x, y)
    super(window, 'lamp.bmp', x, y)
  end
end

class Hans
  include Sprite
end