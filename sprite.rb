require 'weapon'

module Sprite
  TEX_WIDTH  = 64
  TEX_HEIGHT = 64
  
  attr_accessor :x
  attr_accessor :y
  attr_accessor :window
  attr_accessor :slices
  
  def before_draw
  end
  
  def after_draw
  end
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

class Hans
  include Sprite
  include Damageable
  
  def initialize(window, kind_tex_paths, x, y)
    @window = window
    @x = x
    @y = y
    @slices = {}
    @health = 100
    
    kind_tex_paths.each { |kind, tex_paths|
      @slices[kind] = []
      tex_paths.each { |tex_path|
        @slices[kind] << SpritePool::get(window, tex_path, TEX_HEIGHT)
      }
    }
    
    @current_state       = :idle
    @current_tex_seq_id  = 0
  end
  
  def after_draw
    if @current_state == :damaged
      @current_state = :idle
    end
  end
  
  def take_damage_from(player)
    @current_state = :damaged
    @health -= 5
    die if @health <= 0
  end
  
  def die
  end
  
  def slices
    # Serve up current slice
    return @slices[@current_state][@current_tex_seq_id]
  end
  
end