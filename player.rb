require 'weapon'

class Player
  include Damageable
  STEP_SIZE = 8
  ANGLE_SPEED = 5
  FOV = 60.0 # Field of View
  HALF_FOV = FOV / 2
  DISTANCE_TO_PROJECTION = (Config::WINDOW_WIDTH / 2) / Math.tan((FOV / 2) * Math::PI / 180)
  RAY_ANGLE_DELTA = (FOV / Config::WINDOW_WIDTH)
  
  attr_accessor :x
  attr_accessor :y
  attr_accessor :height
  attr_accessor :angle
  attr_accessor :health
  attr_accessor :weapon
  attr_accessor :window
  
  def initialize(window)
    @x = 0.0
    @y = 0.0
    @angle  = 0.0
    @health = 100
    @window = window
  end
  
  def angle_in_radians
    @angle * Math::PI / 180
  end
  
  def turn_left
    @angle = (@angle + ANGLE_SPEED) % 360
  end
  
  def turn_right
    # The added 360 here will make sure that @angle >= 0
    @angle = (360 + @angle - ANGLE_SPEED) % 360
  end
  
  def dx
    # x = r cos(theta)
    STEP_SIZE * Math.cos(self.angle_in_radians)
  end
  
  def dy
    # y = r sin(theta)
    STEP_SIZE * Math.sin(self.angle_in_radians)
  end
  
  def can_move_forward?(map)
    return !map.hit?(@x + 4*dx, @y - 4*dy)
  end
  
  def can_move_backward?(map)
    return !map.hit?(@x - 4*dx, @y + 4*dy)
  end
  
  def move_forward
    @x += dx
    @y -= dy
  end
  
  def move_backward
    @x -= dx
    @y += dy
  end
  
  def take_damage_from(player)
    @health -= 2 # TODO: @health -= player.weapon.damage
  end
  
end