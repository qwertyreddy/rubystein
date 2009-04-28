require 'rubygems'
require 'gosu'
require 'sound'
require 'weapon'
require 'map'

module Sprite
  TEX_WIDTH  = 64
  TEX_HEIGHT = 64
  
  attr_accessor :x
  attr_accessor :y
  attr_accessor :window
  attr_accessor :slices
  attr_accessor :z_order
end

class SpritePool
  @@files = {}
  
  def self.get(window, file_path, sprite_height = Sprite::TEX_HEIGHT, sprite_width = 1)
    file_path = File.expand_path(file_path)
    if !@@files[file_path]
      begin
        @@files[file_path] = Gosu::Image::load_tiles(window, file_path, sprite_width, sprite_height, true)
      rescue
        STDERR.puts "Cannot load #{file_path}"
        raise
      end
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

class TableWithChairs
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'tablechairs.png', TEX_HEIGHT)
  end
end

class Chandelier
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'chandelier.bmp', TEX_HEIGHT)
  end
end

class DeadGuard
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'deadguard.bmp', TEX_HEIGHT)
  end
end

class Bones
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'bones.bmp', TEX_HEIGHT)
  end
end

class Skeleton
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'skeleton.bmp', TEX_HEIGHT)
  end
end

class GreenPlant
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'plantgreen.png', TEX_HEIGHT)
  end
end

class Flag
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'flag.png', TEX_HEIGHT)
  end
end

class Armor
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'armor.png', TEX_HEIGHT)
  end
end

class ColonelSanders
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'colonel_sanders.bmp', TEX_HEIGHT)
  end
end

class Item
  include Sprite
  
  def initialize(window, map, x, y, slices)
    @window = window
    @x = x
    @y = y
    @map = map
    @slices = slices
    @last_interaction_time = 0
  end
  
  def interaction_has_effect?(player)
    # Hack: do not repeatedly interact with player who's standing still.
    if @last_interaction_time + 10 < Time.now.to_f
      my_row, my_column = Map.matrixify(@y, @x)
      player_row, player_column = Map.matrixify(player.y, player.x)
      my_row == player_row && my_column == player_column
    else
      false
    end
  end
  
  def interact(player)
    if interaction_has_effect?(player)
      @last_interaction_time = Time.now.to_f
      execute_interaction_effect(player)
    end
  end
end

class Powerup < Item
  include Sprite
  
  def initialize(window, map, x, y, power_up, slices, sound_file = nil)
    super(window, map, x, y, slices)
    @power_up = power_up
    @interact_sound = SoundPool::get(window, sound_file || 'ammo.mp3')
  end
  
  def interaction_has_effect?(player)
    super(player) && (
      (@power_up > 0 && player.health < Player::MAX_HEALTH) ||
      (@power_up < 0 && player.health > 0)
    )
  end
  
  def execute_interaction_effect(player)
    @interact_sound.play
    @window.show_text(@text) if @text
    new_health = player.health + @power_up
    if new_health > Player::MAX_HEALTH
      new_health = Player::MAX_HEALTH
    elsif new_health < 0
      new_health = 0
    end
    player.health = new_health
    @map.items.delete(self)
  end
end

class Food < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, 25, SpritePool::get(window, 'food.bmp', TEX_HEIGHT))
    @text = 'Food: +25 HP!'
  end
end

class Rails < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, 100, SpritePool::get(window, 'rails.bmp', TEX_HEIGHT))
    @text = 'Rails: +100 HP!'
  end
end

class PHP < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, -25, SpritePool::get(window, 'php.png', TEX_HEIGHT), 'fuck_you.mp3')
    @text = 'PHP: "Fuck you!"'
  end
end

class Info < Item
  def initialize(window, map, x, y, text, change_bg_song_to = nil)
    super(window, map, x, y, SpritePool::get(window, 'info.png', TEX_HEIGHT))
    @text = text
    @sound = SoundPool::get(window, 'Message_Received.ogg')
    @change_bg_song_to = change_bg_song_to
  end
  
  def execute_interaction_effect(player)
    @sound.play
    @window.show_text(@text) if @text
    @window.background_song = @change_bg_song_to if @change_bg_song_to
  end
end