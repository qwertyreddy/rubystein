#!/usr/bin/env ruby
require 'rubygems'
require 'gosu'

require 'map'
require 'player'
require 'sprite'

module ZOrder
  BACKGROUND = 0
  LEVEL      = 1
  SPRITES    = 2
  WEAPON     = 3
  HUD        = 10
end

class GameWindow < Gosu::Window
  # TODO abstract functionality of controller in a module and mixin
  WINDOW_WIDTH  = 640
  WINDOW_HEIGHT = 480
  FULLSCREEN    = true
  FPS           = 60
  
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, FULLSCREEN, 1.0 / FPS)
    self.caption = 'Rubystein 3d by Phusion CS Company'
        
    @map = Map.new([
        # Top left element represents (x=0,y=0)
        [1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 2, 1, 1, 1],
        [1, 0, 0, 0, 0, 1, 0, 1],
        [1, 0, 5, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 6, 4, 3, 1],
        [1, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]],
        [
          { :north => 'blue1_1.png', :east => 'blue1_2.png', :south => 'blue1_1.png', :west => 'blue1_2.png' },
          { :north => 'grey1_1.png', :east => 'grey1_2.png', :south => 'grey1_1.png', :west => 'grey1_2.png' },
          { :north => 'wood1_1.png', :east => 'wood1_2.png', :south => 'wood1_1.png', :west => 'wood1_2.png' },
          { :north => 'wood_php_1.png', :east => 'wood_php_1.png', :south => 'wood_php_1.png', :west => 'wood_php_1.png' },
          { :north => 'blue2_1.png', :east => 'blue1_2.png', :south => 'blue1_1.png', :west => 'blue1_2.png' },
          { :north => 'blue3_1.png', :east => 'blue3_2.png', :south => 'blue3_1.png', :west => 'blue3_2.png' }
        ],
        [ Lamp.new(self, 288, 96), Lamp.new(self, 224, 224), Hans.new(self, 'hans1.bmp', 160, 160) ],
        self
    )
    
    @player = Player.new
    @player.height = 0.5
    @player.x = 96
    @player.y = 96
    @player.angle = 0
    
    @wall_distances = [0] * WINDOW_WIDTH
    @wall_perp_distances = [0] * WINDOW_WIDTH
    
    @hud = Gosu::Image::new(self, 'hud.png', true)
    @weapon_idle = Gosu::Image::new(self, 'hand1.bmp', true)
    @weapon_fire = Gosu::Image::new(self, 'hand2.bmp', true)
    @floor_ceil = Gosu::Image::new(self, 'floor_ceil.png', true)
  end

  def update
    process_movement_input
  end

  def process_movement_input
    @player.turn_left  if button_down? Gosu::Button::KbLeft
    @player.turn_right if button_down? Gosu::Button::KbRight
    @player.move_forward  if button_down? Gosu::Button::KbUp and @player.can_move_forward?(@map)
    @player.move_backward if button_down? Gosu::Button::KbDown and @player.can_move_backward?(@map)
    
    if button_down? Gosu::KbSpace
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
    @map.sprites.each { |sprite|
      dx = (sprite.x - @player.x)
      dy = (sprite.y - @player.y) * -1 # Correct the angle by mirroring it in x. This is necessary seeing as our grid system increases in y when we "go down"
      
      distance = Math.sqrt( dx ** 2 + dy ** 2 )
      
      sprite_angle =(Math::atan2(dy, dx) * 180 / Math::PI) - @player.angle
      sprite_angle *= -1 # Correct the angle by mirroring it in x. This is necessary seeing as our grid system increases in y when we "go down"
      
      perp_distance = ( distance * Math.cos( sprite_angle * Math::PI / 180 ))#.abs
      next if perp_distance <= 0 # Behind us... no point in drawing this.

      sprite_pixel_factor = ( Player::DISTANCE_TO_PROJECTION / perp_distance )
      
      sprite_size = sprite_pixel_factor * Sprite::TEX_WIDTH
      
      x = ( Math.tan(sprite_angle * Math::PI / 180) * Player::DISTANCE_TO_PROJECTION + (WINDOW_WIDTH - sprite_size)/ 2).to_i
      next if x + sprite_size.to_i < 0 or x >= WINDOW_WIDTH # Out of our screen resolution

      y = (WINDOW_HEIGHT - sprite_size) / 2
      
      i = 0
      while(i < Sprite::TEX_WIDTH && (i * sprite_pixel_factor) < sprite_size)
        slice = x + i * sprite_pixel_factor
        if slice >= 0 && slice < WINDOW_WIDTH && perp_distance < @wall_perp_distances[slice.to_i]
          sprite.slices[i].draw(slice, y, ZOrder::SPRITES, sprite_pixel_factor, sprite_pixel_factor, 0xffffffff)
        end
        
        i += 1
      end
      
      #sprite.slices.each{ |slice|
      #  slice.draw(x, y, ZOrder::SPRITES, sprite_pixel_factor, sprite_pixel_factor) if not @wall_perp_distances[x.to_i].nil? and perp_distance < @wall_perp_distances[x.to_i]
      #  x += sprite_pixel_factor
      #}
    }
  end

  def draw_scene
    @floor_ceil.draw(0, 0, ZOrder::BACKGROUND)
    
    # Raytracing logics
    ray_angle         = (360 + @player.angle + (Player::FOV / 2)) % 360
    ray_angle_delta   = Player::RAY_ANGLE_DELTA
    
    (0...WINDOW_WIDTH).each { |slice|
      type, distance, map_x, map_y = @map.find_nearest_intersection(@player.x, @player.y, ray_angle)
      
      # Correct spherical distortion
      # corrected_distance here is the perpendicular distance between the player and wall.
      corrected_angle = ray_angle - @player.angle
      corrected_distance = distance * Math::cos(corrected_angle * Math::PI / 180)
      
      @wall_distances[slice]      = distance
      @wall_perp_distances[slice] = corrected_distance
      
      slice_height = ((Map::TEX_HEIGHT / corrected_distance) * Player::DISTANCE_TO_PROJECTION)
      slice_y = (WINDOW_HEIGHT - slice_height) * (1 - @player.height)
      
      texture = @map.texture_for(type, map_x, map_y, ray_angle)
      texture.draw(slice, slice_y, ZOrder::LEVEL, 1, slice_height / Map::TEX_HEIGHT)
      
      ray_angle = (360 + ray_angle - ray_angle_delta) % 360
    }
  end

  def draw_hud
    @hud.draw(0, 415, ZOrder::HUD)
  end

  def draw_weapon
    dy = Math.sin(Math.sqrt( @player.x ** 2 + @player.y ** 2 )) * 3
    
    if @fired_weapon
      @weapon_fire.draw(200, 240 + dy, ZOrder::WEAPON)
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
game_window.show