require 'map'

class Door
  attr_accessor :pos
  attr_reader   :state
  OPEN_CLOSE_STEP = 4

  def initialize
    @state = :closed
    @pos   = 0
  end

  def open!
    @state = :opening if closed?
    
    if @state == :opening
      @pos += OPEN_CLOSE_STEP
    end
  end
  
  def open?
    return @pos == Map::GRID_WIDTH_HEIGHT
  end
  
  def close!
    @state = :closing if open?
    
    if @state == :closing
      @pos -= OPEN_CLOSE_STEP
    end
  end
  
  def closed?
    return @pos == 0
  end
  
end