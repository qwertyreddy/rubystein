#!/usr/bin/env ruby
require 'rubygems'
require 'gosu'

require 'config'
require 'map'
require 'weapon'
require 'player'
require 'ai_player'
require 'sprite'
require 'door'

module ZOrder
  BACKGROUND = 0
  LEVEL      = 1
  SPRITES    = 2
  WEAPON     = 3
  HUD        = 10
end

class GameWindow < Gosu::Window
  Infinity = 1.0 / 0
  
  def initialize
    super(Config::WINDOW_WIDTH, Config::WINDOW_HEIGHT, Config::FULLSCREEN, 1.0 / Config::FPS)
    self.caption = 'Rubystein 3d by Phusion CS Company'
    
    @map = Map.new([
        # Top left element represents (x=0,y=0)
        [1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 1, 3,-1, 3, 1, 1],
        [1, 0, 0, 2, 0, 0, 0, 0, 1],
        [1, 0, 0,-1, 0, 0, 0, 0, 1],
        [1, 0, 0, 2, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1]],
        [
          { :north => 'blue1_1.png', :east => 'blue1_2.png', :south => 'blue1_1.png', :west => 'blue1_2.png' },
          { :north => 'door_s_1.png', :east => 'blue1_2.png', :south => 'door_s_1.png', :west => 'blue1_2.png' },
          { :north => 'blue1_1.png', :east => 'door_s_2.png', :south => 'blue1_1.png', :west => 'door_s_2.png' },
          { :north => 'grey1_1.png', :east => 'grey1_2.png', :south => 'grey1_1.png', :west => 'grey1_2.png' },
          { :north => 'wood1_1.png', :east => 'wood1_2.png', :south => 'wood1_1.png', :west => 'wood1_2.png' },
          { :north => 'wood_php_1.png', :east => 'wood_php_1.png', :south => 'wood_php_1.png', :west => 'wood_php_1.png' },
          { :north => 'blue2_1.png', :east => 'blue1_2.png', :south => 'blue1_1.png', :west => 'blue1_2.png' },
          { :north => 'blue3_1.png', :east => 'blue3_2.png', :south => 'blue3_1.png', :west => 'blue3_2.png' },
          { :north => 'door_1.png',  :east => 'door_2.png',  :south => 'door_1.png',  :west => 'door_2.png' }
        ],
        self
    )
    
    @map.sprites = [
      Lamp.new(self, 5.5 * 64, 2.5 * 64),
      Lamp.new(self, 2.5 * 64, 5.5 * 64),
      Hans.new(self, @map, 6 * 64, 92),
      Hans.new(self, @map, 7 * 64, 5 * 64)
    ]
    
    @player = Player.new(self)
    @player.height = 0.5
    @player.x = 64 * 1.5
    @player.y = 64 * 1.5
    @player.angle = 0
    
    @wall_perp_distances   = [0]   * Config::WINDOW_WIDTH
    @drawn_sprite_x        = [nil] * Config::WINDOW_WIDTH
    
    @hud = Gosu::Image::new(self, 'hud.png', true)
    @weapon_idle = Gosu::Image::new(self, 'hand1.bmp', true)
    @weapon_fire = Gosu::Image::new(self, 'hand2.bmp', true)
    @floor_ceil  = Gosu::Image::new(self, 'floor_ceil.png', true)
  end

  def update
    process_movement_input
    invoke_ai
    invoke_doors
  end

  def invoke_ai
    @map.sprites.each { |sprite|
      sprite.interact(@player, @drawn_sprite_x) if sprite.respond_to? :interact
    }
  end

  def invoke_doors
    @map.doors.each { |row|
      row.each { |door|
        door.interact unless door.nil?
      }
    }
  end

  def process_movement_input
    @player.turn_left  if button_down? Gosu::Button::KbLeft
    @player.turn_right if button_down? Gosu::Button::KbRight
    @player.move_forward  if button_down? Gosu::Button::KbUp and @player.can_move_forward?(@map)
    @player.move_backward if button_down? Gosu::Button::KbDown and @player.can_move_backward?(@map)
    
    if button_down? Gosu::Button::KbSpace
      column, row = Map.matrixify(@player.x, @player.y)
      door = @map.get_door(row, column, @player.angle)
      
      if !door.nil?
        if door.open?
          door.close!
        elsif door.closed?
          door.open!
        end
        return
      end
      
      if not ( sprite = @drawn_sprite_x[Config::WINDOW_WIDTH/2] ).nil? and sprite.respond_to? :take_damage_from and sprite.health > 0
        sprite.take_damage_from(@player)
      end
      
      @fired_weapon = true
    else
      @fired_weapon = false
    end
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end

  def draw_sprites
    @drawn_sprite_x.clear
    #@sprite_in_crosshair = nil
    
    @map.sprites.each { |sprite|
      dx = (sprite.x - @player.x)
      # Correct the angle by mirroring it in x. This is necessary seeing as our grid system increases in y when we "go down"
      dy = (sprite.y - @player.y) * -1
      
      distance = Math.sqrt( dx ** 2 + dy ** 2 )
      
      sprite_angle = (Math::atan2(dy, dx) * 180 / Math::PI) - @player.angle
      # Correct the angle by mirroring it in x. This is necessary seeing as our grid system increases in y when we "go down"
      sprite_angle *= -1
      
      perp_distance = ( distance * Math.cos( sprite_angle * Math::PI / 180 ))#.abs
      next if perp_distance <= 0 # Behind us... no point in drawing this.

      sprite_pixel_factor = ( Player::DISTANCE_TO_PROJECTION / perp_distance )
      
      sprite_size = sprite_pixel_factor * Sprite::TEX_WIDTH
      
      x = ( Math.tan(sprite_angle * Math::PI / 180) * Player::DISTANCE_TO_PROJECTION + (Config::WINDOW_WIDTH - sprite_size) / 2).to_i
      next if x + sprite_size.to_i < 0 or x >= Config::WINDOW_WIDTH # Out of our screen resolution

      y = (Config::WINDOW_HEIGHT - sprite_size) / 2
      
      i = 0
      slices = sprite.slices
      
      while(i < Sprite::TEX_WIDTH && (i * sprite_pixel_factor) < sprite_size)
        slice = x + i * sprite_pixel_factor
        slice_idx = slice.to_i
        
        if slice >= 0 && slice < Config::WINDOW_WIDTH && perp_distance < @wall_perp_distances[slice_idx]
          slices[i].draw(slice, y, ZOrder::SPRITES, sprite_pixel_factor, sprite_pixel_factor, 0xffffffff)
          drawn_slice_idx = slice_idx
          
          while((drawn_slice_idx - x) <= ((i+1) * sprite_pixel_factor))
            @drawn_sprite_x[drawn_slice_idx] = sprite
            drawn_slice_idx += 1
          end
        end
        
        i += 1
      end
    }
    
  end

  def draw_scene
    @floor_ceil.draw(0, 0, ZOrder::BACKGROUND)
    
    # Raytracing logics
    ray_angle         = (360 + @player.angle + (Player::FOV / 2)) % 360
    ray_angle_delta   = Player::RAY_ANGLE_DELTA
    
    (0...Config::WINDOW_WIDTH).each { |slice|
      type, distance, map_x, map_y = @map.find_nearest_intersection(@player.x, @player.y, ray_angle)
      
      # Correct spherical distortion
      # corrected_distance here is the perpendicular distance between the player and wall.
      corrected_angle = ray_angle - @player.angle
      corrected_distance = distance * Math::cos(corrected_angle * Math::PI / 180)
      
      @wall_perp_distances[slice] = corrected_distance
      
      slice_height = ((Map::TEX_HEIGHT / corrected_distance) * Player::DISTANCE_TO_PROJECTION)
      slice_y = (Config::WINDOW_HEIGHT - slice_height) * (1 - @player.height)
            
      texture = @map.texture_for(type, map_x, map_y, ray_angle)
      texture.draw(slice, slice_y, ZOrder::LEVEL, 1, slice_height / Map::TEX_HEIGHT)
      
      ray_angle = (360 + ray_angle - ray_angle_delta) % 360
    }
  end

  def draw_hud
    @hud.draw(0, 415, ZOrder::HUD)
  end

  def draw_weapon
    if button_down? Gosu::Button::KbUp
      dy = Math.cos(Time.now.to_f * -10) * 7
    elsif button_down? Gosu::Button::KbDown
      dy = Math.cos(Time.now.to_f * 10) * 7
    else
      dy = Math.cos(Time.now.to_f * 5) * 3
    end
    
    if @fired_weapon
      @weapon_fire.draw(200, 240 + dy, ZOrder::WEAPON)
      @player.fire
    else
      @weapon_idle.draw(200, 276 + dy, ZOrder::WEAPON)
    end
  end

  def draw
    draw_scene
    draw_sprites
    draw_weapon
    draw_hud
  end
  
end

game_window = GameWindow.new
if ARGV[0] == '--profile'
  require 'ruby-prof'
  result = RubyProf.profile do
    game_window.show
  end
  File.open('profile.html', 'w') do |f|
    RubyProf::GraphHtmlPrinter.new(result).print(f, :min_percent => 5)
  end
else
  game_window.show
end