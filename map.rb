class Map
  
  TEX_WIDTH  = 64
  TEX_HEIGHT = 64
  GRID_WIDTH_HEIGHT = 64
  
  attr_accessor :matrix
  attr_reader   :window
  attr_reader   :textures
  
  # @require for i in 0...matrix_row_column.size:
  #   matrix_row_column[i].size == matrix_row_column[i+1].size
  def initialize(matrix_row_column, texture_files, window)
    @matrix = matrix_row_column
    @window = window
    @textures = []
    texture_files.each {|tex_file|
      @textures << Gosu::Image::load_tiles(window, tex_file, 1, TEX_HEIGHT, true)
    }
  end
  
  def hit?(x,y)
    column = (x / GRID_WIDTH_HEIGHT).floor
    row    = (y / GRID_WIDTH_HEIGHT).floor
    
    return @matrix[row][column] != 0
  end
  
end