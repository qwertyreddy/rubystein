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
  SCREEN_FLASH_MAX_ALPHA = 100
  SCREEN_FLASH_STEP      = 5
  POWERDOWN_SCREEN_FLASH_COLOR = Gosu::Color.new(SCREEN_FLASH_MAX_ALPHA, 255, 0, 0)
  POWERUP_SCREEN_FLASH_COLOR   = Gosu::Color.new(SCREEN_FLASH_MAX_ALPHA, 141, 198, 63)
  
  TOP  = 0
  LEFT = 0
  RIGHT = Config::WINDOW_WIDTH - 1
  BOTTOM = Config::WINDOW_HEIGHT - 1
  
  def initialize
    super(Config::WINDOW_WIDTH, Config::WINDOW_HEIGHT, Config::FULLSCREEN, 1000.0 / Config::FPS)
    self.caption = 'Rubystein 3d by Phusion CS Company'
    
    @map = MapPool.get(self, 0)
    
    @player = Player.new(self)
    @player.height = 0.5
    @player.x = @map.player_x_init
    @player.y = @map.player_y_init
    @player.angle = @map.player_angle_init
    
    @wall_perp_distances   = [0]   #* Config::WINDOW_WIDTH
    @drawn_sprite_x        = [nil] #* Config::WINDOW_WIDTH
    
    @hud = Gosu::Image::new(self, 'hud.png', true)
    @hud_numbers = SpritePool.get(self, 'numbers.png', 32, 16)
    @weapon_idle = Gosu::Image::new(self, 'hand1.bmp', true)
    @weapon_fire = Gosu::Image::new(self, 'hand2.bmp', true)
    @floor_ceil  = Gosu::Image::new(self, 'floor_ceil.png', true)
    @song = Gosu::Song.new(self, 'getthem.mp3')
    @song.volume = 0.3
    @song.play(true)
    @fire_sound = Gosu::Sample.new(self, 'fire.wav')
    @door_open_sound = Gosu::Sample.new(self, 'dooropen.mp3')
    @door_close_sound = Gosu::Sample.new(self, 'doorclose.mp3')
    
    # Screenflashing counters
    @powerup_screen_flash   = 0
    @powerdown_screen_flash = 0
    
    @hud_portret = SpritePool::get(self, 'dhh.png', 60, 60)
    
    @ai_schedule_index = 0
    @last_row = nil
    @last_col = nil
  end

  def update
    old_player_health = @player.health
    process_movement_input
    invoke_players
    invoke_items
    invoke_doors
    determine_screen_flash(old_player_health)
    
    row, col = Map.matrixify(@player.y, @player.x)
    if @last_row != row || @last_col != col
      puts "#{col},#{row}"
      @last_row = row
      @last_col = col
    end
  end

  def determine_screen_flash(old_health)
    if old_health < @player.health
      # Power-up
      @powerup_screen_flash   = 100
      @powerdown_screen_flash = 0
    elsif old_health > @player.health
      # Power-down
      @powerdown_screen_flash = 100
      @powerup_screen_flash   = 0
    end
  end

  # Invoke AI players' AI. Maximum of AI_INVOCATIONS_PER_LOOP AI invocations per call.
  def invoke_players
    if @ai_schedule_index > @map.players.size - 1
      @ai_schedule_index = 0
    end
    
    if !@map.players.empty?
      if @map.players.size > Config::AI_INVOCATIONS_PER_LOOP
        max_num_invoked = Config::AI_INVOCATIONS_PER_LOOP
      else
        max_num_invoked = @map.players.size
      end
      num_invoked = 0
      i = 0
      real_index_of_last_invoked_ai_player = 0
      
      while i < @map.players.size && num_invoked < max_num_invoked
        real_index = (@ai_schedule_index + i) % @map.players.size
        ai_player = @map.players[real_index]
        
        dx = @player.x - ai_player.x
        dy = @player.y - ai_player.y
        
        # Only invoke the AI if the player is sufficiently close to the
        # main character.
        square_distance_to_main_character = dx * dx + dy * dy
        
        if square_distance_to_main_character < (ai_player.sight * Map::GRID_WIDTH_HEIGHT) ** 2
          ai_player.interact(@player, @drawn_sprite_x)
          real_index_of_last_invoked_ai_player = real_index
          num_invoked += 1
        end
        
        i += 1
      end
      
      @ai_schedule_index = (real_index_of_last_invoked_ai_player + 1) % @map.players.size
    end
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
      
      sprite_in_crosshair = @drawn_sprite_x[Config::WINDOW_WIDTH/2]
      
      if sprite_in_crosshair && sprite_in_crosshair.respond_to?(:take_damage_from) && sprite_in_crosshair.respond_to?(:dead?) && !sprite_in_crosshair.dead?
        sprite_in_crosshair.take_damage_from(@player)
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
          
          if sprite.respond_to?(:dead?) && !sprite.dead?
            old_sprite = @drawn_sprite_x[drawn_slice_idx]
            old_sprite_is_alive_and_in_front_of_sprite = old_sprite && old_sprite.z_order > sprite.z_order && old_sprite.respond_to?(:dead?) && !old_sprite.dead?
            
            @drawn_sprite_x[drawn_slice_idx] = sprite if not old_sprite_is_alive_and_in_front_of_sprite
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
        texture.draw(slice + n, slice_y, ZOrder::LEVEL, 1, slice_height / Map::TEX_HEIGHT) if texture
        
        ray_angle = (360 + ray_angle - ray_angle_delta) % 360
        n += 1
      end
      
      slice += (n == 0) ? 1 : n
    end
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
    self.draw_number(366, @player.health)
  end

  def draw_number(x, number)
    n = 1
    while (number == 0 && n == 1) || n <= number
      health_digit = (@player.health / n).to_i
      health_digit %= 10
      
      @hud_numbers[health_digit].draw(x, 435, ZOrder::HUD + 1)
      
      x -= 16
      
      n *= 10
    end
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

  def draw_screen_flash
    if @powerdown_screen_flash > 0 || @powerup_screen_flash > 0
      if @powerdown_screen_flash > 0
        screen_flash_color = POWERDOWN_SCREEN_FLASH_COLOR
        screen_flash_color.alpha = @powerdown_screen_flash
        @powerdown_screen_flash -= SCREEN_FLASH_STEP
      elsif @powerup_screen_flash > 0
        screen_flash_color = POWERUP_SCREEN_FLASH_COLOR
        screen_flash_color.alpha = @powerup_screen_flash
        @powerup_screen_flash -= SCREEN_FLASH_STEP
      end
      
      draw_quad(
        TOP, LEFT, screen_flash_color, RIGHT, TOP,
        screen_flash_color, RIGHT, BOTTOM, screen_flash_color,
        LEFT, BOTTOM, screen_flash_color, ZOrder::HUD + 3
      )
    end
  end

  def draw
    draw_scene
    draw_sprites
    draw_weapon
    draw_hud
    draw_screen_flash
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