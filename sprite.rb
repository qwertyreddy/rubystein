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

class MagicPony
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'magic_pony.png', TEX_HEIGHT)
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

class Table
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'table.png', TEX_HEIGHT)
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

class Well
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'well.png', TEX_HEIGHT)
  end
end

class BrownBarrel
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'brownbarrel.png', TEX_HEIGHT)
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

class Vase
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @slices = SpritePool::get(window, 'vase.png', TEX_HEIGHT)
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


# An sprite that interacts with the player when they touch each other.
class Interactable
  include Sprite
  
  attr_accessor :window
  attr_accessor :x
  attr_accessor :y
  attr_accessor :map
  
  def initialize(window, map, x, y, slices)
    @window = window
    @x = x
    @y = y
    @map = map
    @slices = slices
    @last_interaction_time = 0
  end
  
  def interact(player)
    if interaction_has_effect?(player)
      @last_interaction_time = Time.now.to_f
      execute_interaction_effect(player)
    end
  end

  private
  
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
  
  def execute_interaction_effect(player)
  end
end

# An item that can be picked up once.
class Item < Interactable
  def initialize(window, map, x, y, slices, text = nil, sound_file = nil)
    super(window, map, x, y, slices)
    @text  = text
    @sound = SoundPool::get(window, sound_file || 'ammo.mp3')
  end
  
  private
  
  def execute_interaction_effect(player)
    super(player)
    @sound.play
    @window.show_text(@text) if @text
    @map.items.delete(self)
  end
end

# Item which increases or decreases HP. Will only interact when the player's
# HP is < 100% (for positive powerups) and > 0% (for negative power ups).
class Powerup < Item
  def initialize(window, map, x, y, slices, power_up, text = nil, sound_file = nil)
    super(window, map, x, y, slices, text, sound_file)
    @power_up = power_up
  end
  
  private
  
  def interaction_has_effect?(player)
    super(player) && (
      (@power_up > 0 && player.health < player.max_health) ||
      (@power_up < 0 && player.health > 0)
    )
  end
  
  def execute_interaction_effect(player)
    super(player)
    new_health = player.health + @power_up
    if new_health > player.max_health
      new_health = player.max_health
    elsif new_health < 0
      new_health = 0
    end
    player.health = new_health
  end
end

class Food < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, SpritePool::get(window, 'food.bmp', TEX_HEIGHT), 25, "Food: +25 HP!")
  end
end

class Peepcode < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, SpritePool::get(window, 'peepcode_powerup.png', TEX_HEIGHT), 50, "Peepcode: +50 HP!")
  end
end

class Rails < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, SpritePool::get(window, 'rails.bmp', TEX_HEIGHT), 100, "Rails: +100 HP!")
  end
end

class PHP < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, SpritePool::get(window, 'php.png', TEX_HEIGHT), -25,
          'PHP: "Fuck you!"', 'fuck_you.mp3')
  end
end

class Fries < Powerup
  def initialize(window, map, x, y)
    super(window, map, x, y, SpritePool::get(window, 'ronald_dead10.png', TEX_HEIGHT), 40,
          "French Fries: +40 HP!\nBut don't eat too much, it's bad for your health.",
          'fuck_you.mp3')
  end
end

class Info < Interactable
  attr_accessor :play_sound
  
  def initialize(window, map, x, y, text = nil, change_bg_song_to = nil, &block)
    super(window, map, x, y, SpritePool::get(window, @image || 'info.png', TEX_HEIGHT))
    @play_sound = true
    @text = text
    @sound = SoundPool::get(window, 'Message_Received.ogg')
    @change_bg_song_to = change_bg_song_to
    @block = block
  end
  
  private
  
  def execute_interaction_effect(player)
    super(player)
    @window.show_text(@text) if @text
    @window.background_song = @change_bg_song_to if @change_bg_song_to
    @block.call(self, player) if @block
    @sound.play if @play_sound
  end
end

class InvisibleInfo < Info
  def initialize(window, map, x, y, text = nil, change_bg_song_to = nil, &block)
    @image = 'invisible_item.png'
    super(window, map, x, y, text, change_bg_song_to, &block)
  end
end

class Phusion < Item
  def initialize(window, map, x, y, new_max_health)
    super(window, map, x, y, SpritePool::get(window, 'phusion_logo.png', TEX_HEIGHT))
    @new_max_health = new_max_health
  end
  
  private
  
  def execute_interaction_effect(player)
    super(player)
    @window.show_text("Phusion: Max HP increased from #{player.max_health} to #{@new_max_health}!")
    player.max_health = @new_max_health
    player.health = @new_max_health
  end
end