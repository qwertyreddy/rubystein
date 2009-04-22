#!/usr/bin/env ruby
require 'rubygems'
require 'gosu'

require 'config'
require 'map'
require 'sound'
require 'weapon'
require 'player'
require 'ai_player'
require 'sprite'
require 'door'

require 'level'

module ZOrder
  BACKGROUND = 0
  LEVEL      = 1
  SPRITES    = 2
  WEAPON     = 9999
  HUD        = 10000
end

class GameWindow < Gosu::Window
  Infinity = 1.0 / 0
  
  def initialize
    super(Config::WINDOW_WIDTH, Config::WINDOW_HEIGHT, Config::FULLSCREEN, 1000.0 / Config::FPS)
    self.caption = 'Rubystein 3d by Phusion CS Company'
    
    @map = MapPool.get(self, 0)
        
    @player = Player.new(self)
    @player.height = 0.5
    @player.x = @map.player_x_init
    @player.y = @map.player_y_init
    @player.angle = @map.player_angle_init
    
    @wall_perp_distances   = [0]   * Config::WINDOW_WIDTH
    @drawn_sprite_x        = [nil] * Config::WINDOW_WIDTH
    
    @hud = Gosu::Image::new(self, 'hud.png', true)
    @weapon_idle = Gosu::Image::new(self, 'hand1.bmp', true)
    @weapon_fire = Gosu::Image::new(self, 'hand2.bmp', true)
    @floor_ceil  = Gosu::Image::new(self, 'floor_ceil.png', true)
    @song = Gosu::Song.new(self, 'getthem.mp3')
    @song.volume = 0.3
    @song.play(true)
    @fire_sound = Gosu::Sample.new(self, 'fire.wav')
    @door_open_sound = Gosu::Sample.new(self, 'dooropen.mp3')
    @door_close_sound = Gosu::Sample.new(self, 'doorclose.mp3')
    
    @hud_portret = SpritePool::get(self, 'dhh.png', 60, 60)
    
  end

  def update
    process_movement_input
    invoke_players
    invoke_items
    invoke_doors
    
    row, col = Map.matrixify(@player.y, @player.x)
    puts "#{col},#{row}"
  end

  def invoke_players
    r_threshold = (Map::GRID_WIDTH_HEIGHT * 12) ** 2
    
    @map.players.each { |ai_player|
      dx = @player.x - ai_player.x
      dy = @player.y - ai_player.y
      
      r_2 = dx * dx + dy * dy
      
      if r_2 < r_threshold
        ai_player.interact(@player, @drawn_sprite_x)
      end
    }
  end

  def invoke_items
    @map.items.each { |item|
      item.interact(@player)
    }
  end

  def invoke_doors
    current_time = Time.now.to_i

    @map.doors.each { |doors_row|
      doors_row.each { |door|
        if not door.nil?
          door.interact
          
          row, column = Map.matrixify(@player.y, @player.x)

          if door.open? && @map.doors[row][column] != door && (current_time - door.opened_at) >= Door::STAYS_SECONDS_OPEN
            @door_close_sound.play
            door.close!
          end
        end
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
          @door_close_sound.play
          door.close!
        elsif door.closed?
          @door_open_sound.play
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

      sprite.z_order = ZOrder::SPRITES + ( 1 / (perp_distance / Map::GRID_WIDTH_HEIGHT))
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
          slices[i].draw(slice, y, sprite.z_order, sprite_pixel_factor, sprite_pixel_factor, 0xffffffff)
          drawn_slice_idx = slice_idx
          
          while((drawn_slice_idx - x) <= ((i+1) * sprite_pixel_factor))
            if not (@drawn_sprite_x[drawn_slice_idx] && sprite.z_order > @drawn_sprite_x[drawn_slice_idx].z_order && sprite.respond_to?(:dead?) && sprite.dead?)
              @drawn_sprite_x[drawn_slice_idx] = sprite 
            end
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
    
    #(0...Config::WINDOW_WIDTH).each { |slice|
    slice = 0
    while slice < Config::WINDOW_WIDTH
    
      type, distance, map_x, map_y = @map.find_nearest_intersection(@player.x, @player.y, ray_angle)
      
      # Correct spherical distortion
      # corrected_distance here is the perpendicular distance between the player and wall.
      corrected_angle = ray_angle - @player.angle
      corrected_distance = distance * Math::cos(corrected_angle * Math::PI / 180)
      
      slice_height = ((Map::TEX_HEIGHT / corrected_distance) * Player::DISTANCE_TO_PROJECTION)
      slice_y = (Config::WINDOW_HEIGHT - slice_height) * (1 - @player.height)
            
      n = 0
      while n < Config::SUB_DIVISION && (slice + n) < Config::WINDOW_WIDTH
        @wall_perp_distances[slice + n] = corrected_distance
        texture = @map.texture_for(type, map_x, map_y, ray_angle)
        texture.draw(slice + n, slice_y, ZOrder::LEVEL, 1, slice_height / Map::TEX_HEIGHT)
        
        ray_angle = (360 + ray_angle - ray_angle_delta) % 360
        n += 1
      end
      
      if n == 0
        slice += 1
      else
        slice += n
      end
    end
    #}
  end

  def draw_hud
    @hud.draw(0, 405, ZOrder::HUD)
    if @player.health <= 85 && @player.health > 70
      portret_id = 1
    elsif @player.health <= 70 && @player.health > 55
      portret_id = 2
    elsif @player.health <= 55 && @player.health > 40
      portret_id = 3
    elsif @player.health <= 40 && @player.health > 25
      portret_id = 4
    elsif @player.health <= 25 && @player.health > 10
      portret_id = 5
    elsif @player.health <= 10
      portret_id = 6
    else
      portret_id = 0
    end
    
    
    @hud_portret[portret_id].draw(268, 414, ZOrder::HUD)
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
      @fire_sound.play(0.2)
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