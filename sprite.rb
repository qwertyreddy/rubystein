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
  
  STEP_SIZE = 3
  
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
    
    @current_state        = :idle
    @current_anim_seq_id  = 0
  end
  
  def after_draw
    if @current_state == :damaged
      @current_state = :firing
    end
  end
  
  def take_damage_from(player)
    return if @current_state == :dead
    @health -= 5
    @current_state = (@health > 0) ? :damaged : :dead
  end
  
  def walk_to(map, x, y)
    return if @current_state == :dead
    @current_state = :walking
    dx = x - @x
    dy = (y - @y) * -1
    
    angle_rad = Math::atan2(dy, dx) * -1
    
    @x += STEP_SIZE * Math::cos(angle_rad)
    @y += STEP_SIZE * Math::sin(angle_rad)
  end
  
  def slices
    # Serve up current slice
    @current_anim_seq_id = ((Time.now.to_f * 4) % @slices[@current_state].size).to_i
    return @slices[@current_state][@current_anim_seq_id]
  end
  
end