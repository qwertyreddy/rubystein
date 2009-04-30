require 'map'
require 'sprite'
require 'weapon'
require 'sound'

module AStar
  Coordinate = Struct.new(:x, :y)
  
  def find_path(map, start, goal)
    start  = Coordinate.new(start[0], start[1])
    goal   = Coordinate.new(goal[0], goal[1])
    
    closed = []
    open   = [start]
    
    g_score = {}
    h_score = {}
    f_score = {}
    came_from = {}
    
    g_score[start] = 0
    h_score[start] = heuristic_estimate_of_distance(start, goal)
    f_score[start] = h_score[start]
    
    while not open.empty?
      x = smallest_f_score(open, f_score)
      return reconstruct_path(came_from, goal) if x == goal
      
      open.delete(x)
      closed << x
      neighbor_nodes = neighbor_nodes(map, x)
      
      neighbor_nodes.each do |y|
        next if closed.include?(y) or not map.walkable?(y.y, y.x)
        
        tentative_g_score = g_score[x] + dist_between(x, y)
        tentative_is_better = false
        if not open.include?(y)
          open << y
          h_score[y] = heuristic_estimate_of_distance(y, goal)
          tentative_is_better = true
        elsif tentative_g_score < g_score[y]
          tentative_is_better = true
        end
        
        if tentative_is_better
          came_from[y] = x
          g_score[y] = tentative_g_score
          f_score[y] = g_score[y] + h_score[y]
        end
      end
    end
    
    # No path found
    return nil
  end
  
  def dist_between(a, b)
    col_a, row_a = Map.matrixify(a.x, a.y)
    col_b, row_b = Map.matrixify(b.x, b.y)
    
    if col_a == col_b && row_a != row_b
      1.0
    elsif col_a != col_b && row_a == row_b
      1.0
    else
      1.4142135623731 # Sqrt(1**2 + 1**2)
    end
  end
  
  def neighbor_nodes(map, node)
    node_x, node_y = node.x, node.y
    result = []

    x = node_x - 1
    x_max = node_x + 1
    y_max = node_y + 1
    while(x <= x_max && x < map.width)
      y = node_y - 1
      
      while(y <= y_max && y < map.height)
        result << Coordinate.new(x, y) unless (x == node_x && y == node_y)
        y += 1
      end
      
      x += 1
    end
    
    return result
    
  end
  
  def heuristic_estimate_of_distance(start, goal)
    # Manhattan distance
    (goal.x - start.x).abs + (goal.y - start.y).abs
  end
  
  def reconstruct_path(came_from, current_node)
    #puts "START TRACE"
    
    while came_from[current_node]
      #puts "#{current_node[0]}, #{current_node[1]}"
      parent = came_from[current_node]
      
      if came_from[parent].nil?
        # No more parent for this node, return the current_node
        return current_node
      else
        current_node = parent
      end
    end
    
    #puts "No path found"
  end
  
  def smallest_f_score(list_of_coordinates, f_score)
    x_min = list_of_coordinates[0]
    f_min = f_score[x_min]
    
    list_of_coordinates.each {|x|
      if f_score[x] < f_min
        f_min = f_score[x]
        x_min = x
      end
    }
    
    return x_min
  end
  
end

class AIPlayer
  include AStar
  include Sprite
  include Damageable
  
  # Maximum distance (in blocks) that this player can see.
  attr_accessor :sight
  # This enemy must not be closer than the given number of blocks to the main character.
  attr_accessor :min_dinstance
  
  attr_accessor :steps_removed_from_player
  
  def initialize(sight = 10, min_distance = 2)
    @sight = sight
    @min_distance = min_distance
  end
  
  def interact(player, drawn_sprite_x)
    return if @health <= 0
    
    self.current_state = :idle if @current_state == :firing && @firing_left == 0
    
    if @firing_left > 0
      if (@current_anim_seq_id == 0)
        self.fire(player)
      end
      @firing_left -= 1
      return
    end
    
    if (drawn_sprite_x.include?(self) && rand > 0.8)
      @firing_left = 1 + rand(5)
    end
    
    #dx = player.x - @x
    #dy = (player.y - @y) * -1
    
    #angle_rad = Math::atan2(dy, dx)
    #dx = @steps_removed_from_player * @step_size * Math::cos(angle_rad)
    #dy = @steps_removed_from_player * @step_size * Math::sin(angle_rad)
    
    dx = 0
    dy = 0
    
    start = Coordinate.new(*Map.matrixify(@x, @y))
    goal  = Coordinate.new(*Map.matrixify(player.x - dx, player.y - dy))
    if heuristic_estimate_of_distance(start, goal) > @min_distance
      path  = self.find_path(@map, start, goal)
      if path
        self.step_to_adjacent_squarily(path.y, path.x)
      end
    end
  end
end

class Enemy < AIPlayer
  FIRING_SOUND_BLOCKS = 2.5
  
  attr_accessor :step_size
  attr_accessor :animation_interval
  
  def initialize(window, kind_tex_paths, map, x, y, death_sound, firing_sound, kill_score = 100, step_size = 4, animation_interval = 0.2)
    super()
    @window = window
    @x = x
    @y = y
    @slices = {}
    @health ||= 100
    @map = map
    @steps_removed_from_player = 22
    @firing_left = 0
    @kill_score  = kill_score
    @firing_sound = SoundPool::get(window, firing_sound)
    @death_sound  = SoundPool::get(window, death_sound)
    @name       ||= self.class.to_s
    @firing_text  = "#{@name}: \"#{SOUND_TO_TEXT[firing_sound]}\"" if SOUND_TO_TEXT.has_key?(firing_sound)
    @death_text   = "#{@name}: \"#{SOUND_TO_TEXT[death_sound]}\"" if SOUND_TO_TEXT.has_key?(death_sound)
    
    kind_tex_paths.each { |kind, tex_paths|
      @slices[kind] = []
      tex_paths.each { |tex_path|
        @slices[kind] << SpritePool::get(window, tex_path, TEX_HEIGHT)
      }
    }
    
    @step_size = step_size
    @animation_interval = animation_interval
    
    self.current_state = :idle
    @last_draw_time = Time.now.to_f
  end
  
  def take_damage_from(player)
    return if @current_state == :dead
    @health -= 5 # TODO: Need to refactor this to take into account different weapons.
    if @health > 0
      self.current_state = :damaged
    else
      self.current_state = :dead
      @firing_sound_sample.stop if @firing_sound_sample
      @death_sound.play
      @window.show_text(@death_text) if @death_text
      player.score += @kill_score
    end
  end
  
  def step_to_adjacent_squarily(target_row, target_column)
    my_column, my_row = Map.matrixify(@x, @y)
    x = my_column
    y = my_row
    
    if my_column == target_column || my_row == target_row
      type = "orthogonal"
      # Orthogonal
      x = target_column # * Map::GRID_WIDTH_HEIGHT
      y = target_row    # * Map::GRID_WIDTH_HEIGHT
    else
      # Diagonal
      type = "diagonal"
      x = my_column
      y = target_row
      
      if not @map.walkable?(y, x)
        x = target_column
        y = my_row
      end
    end
    
    x += 0.5
    y += 0.5
    
    x *= Map::GRID_WIDTH_HEIGHT
    y *= Map::GRID_WIDTH_HEIGHT
    
    #puts "#{Time.now} -- (#{x}, #{y})"
    self.step_to(x, y)
    
  end
  
  def step_to(x, y)
    return if @current_state == :dead
    
    if (@x == x && @y == y)
      self.current_state = :idle
      return
    end
    
    self.current_state = :walking if self.current_state != :walking &&
      @current_anim_seq_id + 1 == @slices[@current_state].size
    
    dx = x - @x
    dy = (y - @y) * -1
    
    angle_rad = Math::atan2(dy, dx) * -1
    
    @x += @step_size * Math::cos(angle_rad)
    @y += @step_size * Math::sin(angle_rad)
  end
  
  def current_state
    @current_state
  end
  
  def current_state=(state)
    @current_state       = state
    @current_anim_seq_id = 0
    if state == :idle || state == :walking || state == :firing
      @repeating_anim = true
    else
      @repeating_anim = false
    end
  end
  
  def slices
    # Serve up current slice
    now = Time.now.to_f
    
    if @current_state == :dead && @current_anim_seq_id + 1 == @slices[:dead].size && !@on_death_called
      @on_death_called = true
      on_death
    end
    
    if not (( @current_state == :dead and @current_anim_seq_id + 1 == @slices[:dead].size ) or (@current_state == :idle))
      if now >= @last_draw_time + @animation_interval
        @current_anim_seq_id += 1
        if @repeating_anim
          @current_anim_seq_id = @current_anim_seq_id % @slices[@current_state].size
        else
          if @current_anim_seq_id >= @slices[@current_state].size
            self.current_state = :idle
          end
        end
        
        @last_draw_time = now
      end
    end
    
    return @slices[@current_state][@current_anim_seq_id]
  end
  
  def fire(player)
    return if @current_status == :dead
    dx = player.x - @x
    dy = player.y - @y
    r_2 = dx * dx + dy * dy
    f_2 = FIRING_SOUND_BLOCKS * FIRING_SOUND_BLOCKS * Map::GRID_WIDTH_HEIGHT * Map::GRID_WIDTH_HEIGHT
    r_2 = f_2 if r_2 < f_2
    
    volume = f_2 / (r_2 * 1.25)
    
    if @firing_sound_sample.nil? || !@firing_sound_sample.playing?
      @firing_sound_sample = @firing_sound.play(volume)
      @window.show_text(@firing_text) if @firing_text
    end
    player.take_damage_from(self)
    
    self.current_state = :firing
  end
  
  private
  
  def on_death
    @map.players.delete(self)
    @map.props << MagicPony.new(@window, @x, @y)
  end
end

class MeleeEnemy < Enemy
  def interact(player, drawn_sprite_x)
    return if @health <= 0
    
    self.current_state = :idle if @current_state == :firing && @firing_left == 0
    
    if @firing_left > 0
      if (@current_anim_seq_id == 0)
        self.fire(player)
      end
      @firing_left -= 1
      return
    end
    
    start = Coordinate.new(*Map.matrixify(@x, @y))
    goal  = Coordinate.new(*Map.matrixify(player.x, player.y))
    
    h = heuristic_estimate_of_distance(start, goal)
    
    if h > @min_distance
      path  = self.find_path(@map, start, goal)
      if path
        self.step_to_adjacent_squarily(path.y, path.x)
      end
    elsif h == @min_distance && drawn_sprite_x.include?(self) && rand > 0.5
      @firing_left = 1 + rand(5)
    end
  end
end

class Guard < Enemy
  def initialize(window, map, x, y, death_sound = nil, firing_sound = nil, kill_score = 100, step_size = 3, animation_interval = 0.2)
    sprites = {
      :idle    => ['guard_idle.png'],
      :walking => ['guard_walking.png', 'guard_walking2.png', 'guard_walking3.png', 'guard_walking4.png'],
      :firing  => ['guard_firing.png', 'guard_firing2.png'],
      :damaged => ['guard_damaged.png', 'guard_dead.png'],
      :dead    => ['guard_dead.png', 'guard_dead2.png', 'guard_dead3.png', 'guard_dead4.png', 'guard_dead5.png']
    }
    
    sounds  = ['long live php.mp3', 'myphplife.mp3', 'my damn php life.mp3', 'phpforever.mp3']
    firing_sound ||= sounds[rand(sounds.size - 1)]
    death_sound  ||= sounds[rand(sounds.size - 1)]
    
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
    @health = 50
  end
end

class Hans < Enemy
  def initialize(window, map, x, y, death_sound = nil, firing_sound = 'machine_gun_burst.mp3', kill_score = 1000, step_size = 3, animation_interval = 0.2)
    sprites = {
      :idle    => ['hans1.bmp'],
      :walking => ['hans1.bmp', 'hans2.bmp', 'hans3.bmp', 'hans4.bmp'],
      :firing  => ['hans5.bmp', 'hans6.bmp', 'hans7.bmp'],
      :damaged => ['hans8.bmp', 'hans9.bmp'],
      :dead    => ['hans9.bmp', 'hans10.bmp', 'hans11.bmp']
    }
    
    # Special thanks goes out to Julian Raschke (jlnr on #gosu@irc.freenode.net ) of libgosu.org for recording these samples for us.
    death_sounds  = ['mein_spagetthicode.wav', 'meine_magischen_qpc.wav', 'meine_sql.wav', 'meine_sql.wav']
    death_sound ||= death_sounds[rand(death_sounds.size - 1)]
    
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
  end
end

class Ronald < Enemy
  def initialize(window, map, x, y, death_sound = 'balloon.mp3', firing_sound = 'floating.mp3', kill_score = 2000, step_size = 3, animation_interval = 0.2)
    sprites = {
      :idle    => ['ronald.png'],
      :walking => ['ronald_moving.png', 'ronald_moving2.png'],
      :firing  => ['ronald_attack.png', 'ronald_attack2.png'],
      :damaged => ['ronald_damaged.png'],
      :dead    => ['ronald_dead.png', 'ronald_dead2.png', 'ronald_dead3.png', 'ronald_dead4.png',
                   'ronald_dead5.png', 'ronald_dead6.png', 'ronald_dead7.png', 'ronald_dead8.png',
                   'ronald_dead9.png', 'ronald_dead10.png']
    }
    
    @name = "Pennywise McDonalds"
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
    @health = 250
  end
  
  def on_death
    @map.players.delete(self)
    @map.items << Fries.new(@window, @map, x, y)
  end
end

class Hongli < Enemy
  def initialize(window, map, x, y, death_sound = 'mein_spagetthicode.wav', firing_sound = 'machine_gun_burst.mp3', kill_score = 10000, step_size = 3, animation_interval = 0.2)
    sprites = {
      :idle    => ['hongli.png'],
      :walking => ['hongli.png'],
      :firing  => ['hongli_attack.png', 'hongli_attack2.png'],
      :damaged => ['hongli_damaged.png'],
      :dead    => ['hongli_dead.png', 'hongli_dead2.png', 'hongli_dead3.png', 'hongli_dead4.png']
    }
    
    @name = "Hongli Lai"
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
    @health = 200
  end
  
  private
  
  def on_death
    # Do not turn into Pony.
  end
end

class Ninh < Enemy
  def initialize(window, map, x, y, death_sound = 'mein_spagetthicode.wav', firing_sound = 'machine_gun_burst.mp3', kill_score = 10000, step_size = 3, animation_interval = 0.2)
    sprites = {
      :idle    => ['ninh.png'],
      :walking => ['ninh.png'],
      :firing  => ['ninh_attack.png'],
      :damaged => ['ninh_damaged.png'],
      :dead    => ['ninh_dead.png', 'ninh_dead2.png', 'ninh_dead3.png', 'ninh_dead4.png']
    }
    
    @name = "Ninh Bui"
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
    @health = 200
  end
  
  private
  
  def on_death
    # Do not turn into Pony.
  end
end

class Zed < Enemy
  def initialize(window, map, x, y, death_sound = 'omgponies.mp3', firing_sound = 'machine_gun_burst.mp3', kill_score = 10000, step_size = 3, animation_interval = 0.2)
    sprites = {
      :idle    => ['zedshaw.png'],
      :walking => ['zedshaw_walking.png', 'zedshaw_walking2.png'],
      :firing  => ['zedshaw_attack.png', 'zedshaw_attack2.png'],
      :damaged => ['zedshaw_damaged.png'],
      :dead    => ['zedshaw_dead.png', 'zedshaw_dead2.png', 'zedshaw_dead3.png']
    }
    
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
    @health = 300
  end
end

class TrueZed < Enemy
  def initialize(window, map, x, y, death_sound = 'omgponies.mp3', firing_sound = 'test_all_the_effing_time_is_lame.mp3', kill_score = 10000, step_size = 3, animation_interval = 0.2)
    sprites = {
      :idle    => ['rockzed.png'],
      :walking => ['rockzed_moving.png', 'rockzed_moving2.png'],
      :firing  => ['rockzed_attacking.png', 'rockzed_attacking2.png', 'rockzed_attacking3.png',
                   'rockzed_attacking4.png', 'rockzed_attacking5.png', 'rockzed_attacking6.png',
                   'rockzed_attacking7.png', 'rockzed_attacking8.png', 'rockzed_attacking9.png'],
      :damaged => ['rockzed_damaged.png'],
      :dead    => ['rockzed_dead.png', 'rockzed_dead2.png', 'rockzed_dead4.png', 'rockzed_dead5.png',
                   'rockzed_dead6.png']
    }
    
    @name = "True Zed Shaw"
    @health = 500
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
  end
end

class Thin < Enemy
  def initialize(window, map, x, y, death_sound = nil, firing_sound = nil, kill_score = 500, step_size = 3, animation_interval = 0.5)
    sprites = {
      :idle    => ['thin.png'],
      :walking => ['thin.png', 'thin2.png'],
      :firing  => ['thin_attacking.png', 'thin_attacking2.png'],
      :damaged => ['thin_damaged.png'],
      :dead    => ['magic_pony.png']
    }
    
    sounds         = ['mein_spagetthicode.wav', 'meine_magischen_qpc.wav', 'meine_sql.wav', 'meine_sql.wav']
    death_sound  ||= 'omgponies.mp3'
    firing_sound ||= sounds[rand(sounds.size - 1)]
    
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
    @health = 200
    @min_distance = 1
  end
end

class Dog < MeleeEnemy
  def initialize(window, map, x, y, death_sound = 'omgponies.mp3', firing_sound = 'dog_bark.mp3', kill_score = 500, step_size = 7, animation_interval = 0.2)
    sprites = {
      :idle => ['dog_walking.png'],
      :walking => ['dog_walking.png', 'dog_walking2.png', 'dog_walking3.png', 'dog_walking4.png'],
      :firing  => ['dog_attacking.png', 'dog_attacking2.png', 'dog_attacking3.png'],
      :damaged => ['dog_dead.png', 'dog_dead2.png'],
      :dead    => ['magic_pony.png']
    }
    
    @name = "Mongrel"
    super(window, sprites, map, x, y, death_sound, firing_sound, kill_score, step_size, animation_interval)
    @health = 100
    @min_distance = 1
  end
end