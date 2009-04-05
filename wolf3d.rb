#!/usr/bin/env ruby
require 'rubygems'
require 'gosu'

require 'map'
require 'player'

class GameWindow < Gosu::Window
  # TODO abstract functionality of controller in a module and mixin
  WINDOW_WIDTH  = 640
  WINDOW_HEIGHT = 480
  
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, false)
    self.caption = 'Rubenstein 3d by Phusion CS Company'
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    
    @map = Map.new([
        # Top left element represents (x=0,y=0)
        [1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1],
        [1, 0, 1, 0, 0, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]],
        [
          {
            :horizontal => 'blue1_1.png',
            :vertical   => 'blue1_2.png'
          }
        ],
        self
    )
    
    @player = Player.new
    @player.height = 0.5
    @player.x = 66
    @player.y = 66
    @player.angle = 0
    
    #@bg = Gosu::Image.new(self, 'grid.png', true)
    #@image = Gosu::Image.new(self, 'blue1_1.png', true)
  end

  def update
    @player.turn_left  if button_down? Gosu::Button::KbLeft
    @player.turn_right if button_down? Gosu::Button::KbRight
    @player.move_forward  if button_down? Gosu::Button::KbUp and @player.can_move_forward?(@map)
    @player.move_backward if button_down? Gosu::Button::KbDown and @player.can_move_backward?(@map)
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end

  def draw
    # Raytracing logics
    ray_angle         = (360 + @player.angle + (Player::FOV / 2)) % 360
    ray_angle_delta   = Player::RAY_ANGLE_DELTA
    
    for slice in 0...WINDOW_WIDTH
      type, distance, map_x, map_y = @map.find_nearest_intersection(@player.x, @player.y, ray_angle)
      
      # Remove spherical distortion
      #corrected_angle = ray_angle - @player.angle
      #puts corrected_angle
      #distance = distance * Math::cos(corrected_angle)
      #puts distance
      
      
      slice_height = ((Map::TEX_HEIGHT / distance) * Player::DISTANCE_TO_PROJECTION)
      slice_y = (WINDOW_HEIGHT - slice_height) * (1 - @player.height)
      
      texture = @map.texture_for(type, map_x, map_y)
      texture.draw(slice, slice_y, 1, 1, slice_height / Map::TEX_HEIGHT)
      
      ray_angle = (ray_angle - ray_angle_delta + 360) % 360
      #draw_line(@player.x, @player.y, 0xffffff00, map_x, map_y, 0xffffff00, 3)
    end
    
    
    
    #@image.draw_rot(@player.x, @player.y, 2, @player.angle * -1)
    #@bg.draw(0,0,0)
  end
  
end

game_window = GameWindow.new
game_window.show