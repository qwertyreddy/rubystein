class Player  
  STEP_SIZE = 6
  ANGLE_SPEED = 4
  FOV = 60.0 # Field of View
  DISTANCE_TO_PROJECTION = (640 / 2) / Math.tan((FOV / 2) * Math::PI / 180)
  RAY_ANGLE_DELTA = (FOV / 640)
  # Commented the following line out because I need to refactor the above to something
  # like the following:
  # DISTANCE_TO_PROJECTION = (GameWindow::WINDOW_WIDTH / 2) / Math.tan(FOV / 2)
  
  attr_accessor :x
  attr_accessor :y
  attr_accessor :height
  attr_accessor :angle
  
  def initialize
    @x = 0.0
    @y = 0.0
    @angle = 0.0
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