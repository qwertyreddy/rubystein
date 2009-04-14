require 'map'
require 'sprite'
require 'weapon'

module AStar
  def find_path(map, start, goal)
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
        next if closed.include?(y) or not map.walkable?(y[1], y[0])
        
        tentative_g_score = g_score[x]# + dist_between(x, y)
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
    if a.respond_to?(:x) && a.respond_to?(:y) && b.respond_to?(:x) && b.respond_to?(:y)
      return Math.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2)
    else
      a_x, a_y = a
      b_x, b_y = b
      
      return Math.sqrt((a_x - b_x) ** 2 + (a_y - b_y) ** 2)
    end
  end
  
  def neighbor_nodes(map, node)
    node_x, node_y = node
    result = []

    x = node_x - 1
    x_max = node_x + 1
    y_max = node_y + 1
    while(x <= x_max && x < map.width)
      y = node_y - 1
      
      while(y <= y_max && y < map.height)
        result << [x, y] unless (x == node_x && y == node_y)
        y += 1
      end
      
      x += 1
    end
    
    return result
    
  end
  
  def heuristic_estimate_of_distance(start, goal)
    # Manhattan distance
    start_x, start_y = start
    goal_x, goal_y   = goal
    result = (goal_x - start_x).abs + (goal_y - start_y).abs
    
    return result
  end
  
  def reconstruct_path(came_from, current_node)
    while came_from[current_node]
      parent = came_from[current_node]
      
      if came_from[parent].nil?
        # No more parent for this node, return the current_node
        return current_node
      else
        current_node = parent
      end
    end
    
  end
  
  def smallest_f_score(set, f_score)
    x_min = set[0]
    f_min = f_score[x_min]
    
    set.each {|x|
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
  
  def interact(player)
    path = self.find_path(@map, Map.matrixify(@x, @y), Map.matrixify(player.x, player.y))
    return if path.nil?
    
    x = path[0] * Map::GRID_WIDTH_HEIGHT
    y = path[1] * Map::GRID_WIDTH_HEIGHT
    self.step_to(x, y)
  end
end

class Enemy < AIPlayer
  attr_accessor :step_size
  attr_accessor :animation_interval
    
  def initialize(window, kind_tex_paths, map, x, y, step_size = 4, animation_interval = 0.2)
    @window = window
    @x = x
    @y = y
    @slices = {}
    @health = 100
    @map = map
    
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
    @health -= 5
    self.current_state = (@health > 0) ? :damaged : :dead
  end
  
  def step_to(x, y)
    return if @current_state == :dead
    if @x == x && @y == y
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
end

class Hans < Enemy
  def initialize(window, map, x, y, step_size = 4, animation_interval = 0.2)
    sprites = {
      :idle    => ['hans1.bmp'],
      :walking => ['hans1.bmp', 'hans2.bmp', 'hans3.bmp', 'hans4.bmp'],
      :firing  => ['hans5.bmp', 'hans6.bmp', 'hans7.bmp'],
      :damaged => ['hans8.bmp', 'hans9.bmp'],
      :dead    => ['hans9.bmp', 'hans10.bmp', 'hans11.bmp']
    }
    
    super(window, sprites, map, x, y, step_size, animation_interval)
  end
end