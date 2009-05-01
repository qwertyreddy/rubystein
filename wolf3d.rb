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
require 'image_pool'

require 'level'

module ZOrder
  BACKGROUND = 0
  LEVEL      = 1
  SPRITES    = 2
  WEAPON     = 9999
  HUD        = 10000
  SCREEN_FLASH    = HUD + 3
  TEXT_BACKGROUND = HUD + 4
  TEXT            = HUD + 5
  FADE_OUT_OVERLAY = HUD + 6
end

class GameWindow < Gosu::Window
  Infinity = 1.0 / 0
  SCREEN_FLASH_MAX_ALPHA = 100
  SCREEN_FLASH_STEP      = 5
  POWERDOWN_SCREEN_FLASH_COLOR = Gosu::Color.new(SCREEN_FLASH_MAX_ALPHA, 255, 0, 0)
  POWERUP_SCREEN_FLASH_COLOR   = Gosu::Color.new(SCREEN_FLASH_MAX_ALPHA, 141, 198, 63)
  TEXT_BACKGROUND_COLOR        = Gosu::Color.new(160, 0, 0, 0)
  TEXT_BACKGROUND_PADDING      = 6
  TEXT_VERTICAL_SPACING        = 1
  MIN_TEXT_APPEARENCE_TIME     = 3
  FADE_OUT_OVERLAY_COLOR       = Gosu::Color.new(0, 0, 0, 0)
  BOSS_PRESENTATION_BACKGROUND_COLOR = Gosu::Color.new(255, 0, 61, 204)
  BOSS_PRESENTATION_CYAN_LINE_COLOR  = Gosu::Color.new(255, 0, 186, 251)
  BOSS_PRESENTATION_WHITE_LINE_COLOR = Gosu::Color.new(255, 255, 255, 255)
  BOSS_PRESENTATION_TITLE_FONT = "Myriad Pro"
  BOSS_PRESENTATION_TITLE_FONT_SIZE = 35
  BOSS_PRESENTATION_FONT       = "Myriad Pro"
  BOSS_PRESENTATION_FONT_SIZE  = 45
  
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
    @rainbow     = Gosu::Image.new(self, 'rainbow.png', true)
    @floor_ceil  = Gosu::Image::new(self, 'floor_ceil.png', true)
    self.background_song = nil  # Play default background song.
    @fire_sound = Gosu::Sample.new(self, 'fire.wav')
    @door_open_sound = Gosu::Sample.new(self, 'dooropen.mp3')
    @door_close_sound = Gosu::Sample.new(self, 'doorclose.mp3')
    
    # Screenflashing counters
    @powerup_screen_flash   = 0
    @powerdown_screen_flash = 0
    
    @hud_portret = SpritePool::get(self, 'sean_connery.png', 60, 60)
    
    @mode = :normal
    
    @ai_schedule_index = 0
    @last_row = nil
    @last_col = nil
  end
  
  def background_song=(filename)
    @bg_song.stop if @bg_song
    @bg_song = Gosu::Song.new(self, filename || 'getthem.mp3')
    @bg_song.volume = 0.25
    @bg_song.play(true)
  end

  def update
    case @mode
    when :normal, :fading_out
      update_fade_out_progress
      old_player_health = @player.health
      if @mode != :fading_out
        process_movement_input
        invoke_players
        invoke_items
        invoke_doors
      end
      determine_screen_flash(old_player_health)
      
      row, col = Map.matrixify(@player.y, @player.x)
      if @last_row != row || @last_col != col
        puts "#{col},#{row}"
        @last_row = row
        @last_col = col
      end
      
    when :presenting_boss
      update_boss_presentation_progress
      
    else
      abort "Invalid mode '#{@mode}'"
    end
  end
  
  def draw
    case @mode
    when :normal, :fading_out
      draw_scene
      draw_sprites
      draw_weapon
      draw_hud
      draw_screen_flash
      draw_text
      draw_fade_out_overlay
      
    when :presenting_boss
      draw_boss_presentation
      
    else
      abort "Invalid mode '#{@mode}'"
    end
  end
  
  def show_text(text)
    @active_text = text
    @active_text_timeout = 0.6 + (text.size * 0.15)
    @active_text_timeout = MIN_TEXT_APPEARENCE_TIME if @active_text_timeout < MIN_TEXT_APPEARENCE_TIME
    @active_text_timeout = Time.now + @active_text_timeout
  end
  
  def fade_out(&when_done)
    @mode = :fading_out
    @fade_out = {
      :start_time => Time.now,
      :duration   => 1,
      :progress   => 0,
      :alpha      => 0,
      :when_done  => when_done
    }
  end
  
  def present_boss(name, avatar_filename, title = "Boss", duration = 1, &block)
    fade_out do
      @bg_song.stop
      @mode = :presenting_boss
      @presenting_boss = {
        :name => name,
        :duration => duration,
        :sound => SoundPool.get(self, 'megaman_game_start.mp3').play,
        :avatar => Gosu::Image.new(self, avatar_filename, false),
        :title_image => Gosu::Image.from_text(self, title,
                                              BOSS_PRESENTATION_TITLE_FONT,
                                              BOSS_PRESENTATION_TITLE_FONT_SIZE),
        :name_width => Gosu::Image.from_text(self, name, BOSS_PRESENTATION_FONT,
                                             BOSS_PRESENTATION_FONT_SIZE).width,
        :stars => Gosu::Image.new(self, 'stars.png', false),
        :state => :opening,
        :start_time => Time.now,
        :when_done => block
      }
      update_boss_presentation_progress
    end
  end

  private
  
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
  
  def update_fade_out_progress
    if @fade_out
      @fade_out[:progress] = (Time.now - @fade_out[:start_time]) / @fade_out[:duration]
      @fade_out[:alpha] = (255.0 * @fade_out[:progress]).to_i
      if @fade_out[:progress] > 1
        @mode == :normal
        when_done = @fade_out[:when_done]
        @fade_out = nil
        when_done.call
      end
    end
  end
  
  def update_boss_presentation_progress
    args = @presenting_boss
    
    if button_down?(Gosu::Button::KbSpace)
      args[:state] = :done
      args[:start_time] = Time.now
      args[:duration] = 0
      args[:stars_start_time] = Time.now
    end
    
    case args[:state]
    when :opening
      animation_duration = 0.7
      max_background_size = 100
      args[:background_size] = ((Time.now - args[:start_time]) / animation_duration) * max_background_size
      if args[:background_size] >= max_background_size
        args[:state] = :presenting
        args[:start_time] = Time.now
        args[:chars] = 0
        args[:stars_start_time] = Time.now
      end
      
    when :presenting
      chars_per_second = 6
      args[:chars] = ((Time.now - args[:start_time]) * chars_per_second).to_i
      if args[:chars] > args[:name].size
        args[:chars] = args[:name].size 
        args[:state] = :waiting_until_done
      end
    
    when :waiting_until_done
      if !args[:sound].playing?
        args[:state] = :done
        args[:start_time] = Time.now
      end
      
    when :done
      if Time.now - args[:start_time] > args[:duration]
        args[:sound].stop if args[:sound]
        @presenting_boss = nil
        @bg_song.play(true)
        @mode = :normal
        args[:when_done].call if args[:when_done]
      end
    end
    
    if args[:state] != :opening
      args[:stars_pos] = ((Time.now - args[:stars_start_time]) * -200) % args[:stars].width
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

    @map.doors.each_with_index { |doors_row, doors_row_index|
      doors_row.each_with_index { |door, doors_column_index|
        if not door.nil?
          door.interact
          
          row, column = Map.matrixify(@player.y, @player.x)

          d_row    = row - doors_row_index
          d_column = column - doors_column_index
          r_2 = (d_row * d_row) + (d_column * d_column)
          r_2 = (Door::FULL_VOLUME_WITHIN_GRID_BLOCKS * Door::FULL_VOLUME_WITHIN_GRID_BLOCKS) if r_2 == 0
          
          door_close_sound_volume = (Door::FULL_VOLUME_WITHIN_GRID_BLOCKS * Door::FULL_VOLUME_WITHIN_GRID_BLOCKS) / r_2
          door_close_sound_volume = 1.0 if door_close_sound_volume > 1.0

          if door.open? && @map.doors[row][column] != door && (current_time - door.opened_at) >= Door::STAYS_SECONDS_OPEN
            @door_close_sound.play(door_close_sound_volume) if door_close_sound_volume > 0
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
            
            if not old_sprite_is_alive_and_in_front_of_sprite
              while(drawn_slice_idx < (slice + sprite_pixel_factor))
                # Fill up all the @drawn_sprite_x buffer with current sprite till the next sprite_pixel_factor
                @drawn_sprite_x[drawn_slice_idx] = sprite
                drawn_slice_idx += 1
              end
            end
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
    if @player.health_percent <= 85 && @player.health_percent > 70
      portret_id = 1
    elsif @player.health_percent <= 70 && @player.health_percent > 55
      portret_id = 2
    elsif @player.health_percent <= 55 && @player.health_percent > 40
      portret_id = 3
    elsif @player.health_percent <= 40 && @player.health_percent > 25
      portret_id = 4
    elsif @player.health_percent <= 25 && @player.health_percent > 10
      portret_id = 5
    elsif @player.health_percent <= 10
      portret_id = 6
    else
      portret_id = 0
    end
    
    @hud_portret[portret_id].draw(268, 414, ZOrder::HUD)
    # Health
    draw_number(@player.health, 375)
    # Score
    draw_number(@player.score, 178)
  end

  def draw_number(number, x, y = 435)
    n = 1
    while (number == 0 && n == 1) || n <= number
      digit = (number / n).to_i
      digit %= 10
      
      @hud_numbers[digit].draw(x, y, ZOrder::HUD + 1)
      
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
      @rainbow.draw(270, 110 + dy, ZOrder::WEAPON + 1)
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
        LEFT, BOTTOM, screen_flash_color, ZOrder::SCREEN_FLASH
      )
    end
  end
  
  def draw_text
    if @active_text
      if Time.now > @active_text_timeout
        @active_text = nil
        @active_text_timeout = nil
      else
        images  = ImagePool.get_text(self, @active_text)
        y       = 12
        bg_top  = y
        bg_left = bg_right = bg_bottom = nil
        
        images.each do |image|
          x = (RIGHT - LEFT) / 2 - image.width / 2
          image.draw(x, y, ZOrder::TEXT)
          y += image.height + TEXT_VERTICAL_SPACING
          
          bg_left = x if bg_left.nil? || x < bg_left
          bg_right = x + image.width if bg_right.nil? || x + image.width > bg_right
        end
        bg_bottom = y - TEXT_VERTICAL_SPACING
        
        bg_left   -= TEXT_BACKGROUND_PADDING
        bg_right  += TEXT_BACKGROUND_PADDING
        bg_top    -= TEXT_BACKGROUND_PADDING
        bg_bottom += TEXT_BACKGROUND_PADDING
        
        draw_quad(bg_left, bg_top, TEXT_BACKGROUND_COLOR,
                  bg_right, bg_top, TEXT_BACKGROUND_COLOR,
                  bg_right, bg_bottom, TEXT_BACKGROUND_COLOR,
                  bg_left, bg_bottom, TEXT_BACKGROUND_COLOR,
                  ZOrder::TEXT_BACKGROUND)
      end
    end
  end
  
  def draw_fade_out_overlay
    if @fade_out
      FADE_OUT_OVERLAY_COLOR.alpha = @fade_out[:alpha]
      draw_quad(LEFT,  TOP, FADE_OUT_OVERLAY_COLOR,
                RIGHT, TOP, FADE_OUT_OVERLAY_COLOR,
                RIGHT, BOTTOM, FADE_OUT_OVERLAY_COLOR,
                LEFT,  BOTTOM, FADE_OUT_OVERLAY_COLOR,
                ZOrder::FADE_OUT_OVERLAY)
    end
  end
  
  def draw_boss_presentation
    if @presenting_boss
      args = @presenting_boss
      
      top = (BOTTOM - TOP) / 2 - args[:background_size] / 2
      bottom = top + args[:background_size]
      
      draw_quad(LEFT, top - 50, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, top - 50, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, top - 48, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                LEFT, top - 48, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                1)
      draw_quad(LEFT, top - 25, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, top - 25, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, top - 23, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                LEFT, top - 23, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                1)
      draw_quad(LEFT, top - 15, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                RIGHT, top - 15, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                RIGHT, top - 10, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                LEFT, top - 10, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                1)
      draw_quad(LEFT, top - 7, BOSS_PRESENTATION_BACKGROUND_COLOR,
                RIGHT, top - 7, BOSS_PRESENTATION_BACKGROUND_COLOR,
                RIGHT, top - 4, BOSS_PRESENTATION_BACKGROUND_COLOR,
                LEFT, top - 4, BOSS_PRESENTATION_BACKGROUND_COLOR,
                1)
      draw_quad(LEFT, top, BOSS_PRESENTATION_BACKGROUND_COLOR,
                RIGHT, top, BOSS_PRESENTATION_BACKGROUND_COLOR,
                RIGHT, bottom, BOSS_PRESENTATION_BACKGROUND_COLOR,
                LEFT, bottom, BOSS_PRESENTATION_BACKGROUND_COLOR,
                1)
      draw_quad(LEFT, bottom + 50, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, bottom + 50, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, bottom + 48, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                LEFT, bottom + 48, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                1)
      draw_quad(LEFT, bottom + 25, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, bottom + 25, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                RIGHT, bottom + 23, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                LEFT, bottom + 23, BOSS_PRESENTATION_WHITE_LINE_COLOR,
                1)
      draw_quad(LEFT, bottom + 15, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                RIGHT, bottom + 15, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                RIGHT, bottom + 10, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                LEFT, bottom + 10, BOSS_PRESENTATION_CYAN_LINE_COLOR,
                1)
      draw_quad(LEFT, bottom + 7, BOSS_PRESENTATION_BACKGROUND_COLOR,
                RIGHT, bottom + 7, BOSS_PRESENTATION_BACKGROUND_COLOR,
                RIGHT, bottom + 4, BOSS_PRESENTATION_BACKGROUND_COLOR,
                LEFT, bottom + 4, BOSS_PRESENTATION_BACKGROUND_COLOR,
                1)
      
      if args[:state] == :presenting || args[:state] == :waiting_until_done || args[:state] == :done
        args[:stars].draw(args[:stars_pos], 0, 2)
        args[:stars].draw(args[:stars_pos] - args[:stars].width, 0, 2)
        args[:stars].draw(args[:stars_pos] + args[:stars].width, 0, 2)
        args[:stars].draw(args[:stars_pos], BOTTOM - args[:stars].height, 2)
        args[:stars].draw(args[:stars_pos] - args[:stars].width, BOTTOM - args[:stars].height, 2)
        args[:stars].draw(args[:stars_pos] + args[:stars].width, BOTTOM - args[:stars].height, 2)
        
        args[:title_image].draw((RIGHT - LEFT) / 2 - args[:title_image].width / 2,
                                top - args[:title_image].height - 80, 3)
        
        image = Gosu::Image.from_text(self, args[:name][0 .. args[:chars]],
                    BOSS_PRESENTATION_FONT, BOSS_PRESENTATION_FONT_SIZE)
        image.draw((RIGHT - LEFT) / 2 - args[:name_width] / 2, bottom + 80, 3)
      end
      if args[:state] == :waiting_until_done || args[:state] == :done
        args[:avatar].draw((RIGHT - LEFT) / 2 - args[:avatar].width / 2,
                           (BOTTOM - TOP) / 2 - args[:avatar].height / 2,
                           2)
      end
    end
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