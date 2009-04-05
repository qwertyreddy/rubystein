class Player  
  STEP_SIZE = 1
  
  attr_accessor :x
  attr_accessor :y
  attr_accessor :height
  attr_accessor :angle
  
  attr_accessor :fov
  
  def initialize
    @x = 0.0
    @y = 0.0
    @angle = 0.0
    @fov   = 64
  end
  
  def angle_in_radians
    @angle * Math::PI / 180
  end
  
  def turn_left
    # This should actually be @angle + 4 but Gosu doesn't
    # use polar coordinates...
    @angle = (@angle + 4) % 360
  end
  
  def turn_right
    # This should actually be @angle - 4 but Gosu doesn't
    # use polar coordinates...
    @angle = (@angle - 4) % 360
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
    return !map.hit?(@x + dx, @y - dy)
  end
  
  def can_move_backward?(map)
    return !map.hit?(@x - dx, @y + dy)
  end
  
  def move_forward
    @x += dx
    @y -= dy
  end
  
  def move_backward
    @x -= dx
    @y += dy
  end
  
end