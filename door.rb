require 'map'

class Door
  attr_accessor :pos
  attr_reader   :state
  attr_reader   :opened_at
  OPEN_CLOSE_STEP = 1
  STAYS_SECONDS_OPEN = 7

  def initialize
    @state = :closed
    @pos   = 0
    @opened_at = 0
  end

  def open!
    if closed?
      @state = :opening
      @opened_at = Time.now.to_i
    end
    
    if !open? && @state == :opening
      @pos += OPEN_CLOSE_STEP
    end
  end
  
  def open?
    return @pos == Map::GRID_WIDTH_HEIGHT
  end
  
  def close!
    if open?
      @state = :closing
    end
    
    if !closed? && @state == :closing
      @pos -= OPEN_CLOSE_STEP
    end
  end
  
  def closed?
    return @pos == 0
  end
  
  def interact
    if @state == :opening
      open!
    elsif @state == :closing
      close!
    end
  end
  
end