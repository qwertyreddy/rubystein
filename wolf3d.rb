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
    self.caption = 'Wolf3d by Phusion CS Company'
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    
    @map = Map.new([
        # Top left element represents (x=0,y=0)
        [1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 1, 1, 1, 1, 1],
        [1, 0, 1, 0, 0, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]],
        ['blue1_1.png', 'blue1_2.png'],
        self
    )
    
    @player = Player.new
    @player.height = 32
    @player.x = 66
    @player.y = 66
    @player.angle = 0
    
    @bg = Gosu::Image.new(self, 'grid.png', true)
    @image = Gosu::Image.new(self, 'blue1_1.png', true)
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
    
    @image.draw_rot(@player.x, @player.y, 1, -1 * @player.angle)
    @bg.draw(0,0,0)
  end
  
end

game_window = GameWindow.new
game_window.show