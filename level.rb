require 'map'

class Level0
private
  def new
  end
  
public
  MATRIX = [
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,18,5,5,5,18,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,4,1,1,1,1,1,1,4,4,4,4,4,4,4,4,4,4,4,5,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,4,4,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,4,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,4,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,4,4,4,4,4,4,4,4,4,4,1,4,0,0,0,4,4,4,4,4,4,4,5,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,4,1,4,0,0,0,4,1,1,1,1,1,1,5,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,4,4,4,0,0,0,4,4,4,1,1,1,1,5,5,5,14,5,21,-1,7,5,14,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4,1,1,1,1,5,5,5,5,5,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,4,1,1,1,1,1,1,5,5,5,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4,1,1,1,1,1,1,5,5,5,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,1,1,1,1,1,1,1,5,5,5,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,9,-1,9,4,4,4,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,0,0,0,0,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,9,-1,9,4,4,4,4,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,0,0,0,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,0,0,0,0,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,0,0,0,4,0,0,0,4,4,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,9,-1,9,4,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,7,-1,7,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,4,4,1,1,1,1,1,1,1,1,4,4,4,4,4,14,0,0,0,0,0,14,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,4,4,1,1,1,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,4,4,1,1,1,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,0,8,0,0,0,0,0,0,0,0,0,4,4,1,1,1,1,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,4,4,1,1,1,1,1,1,1,1,1,4,0,0,0,0,15,16,0,0,0,17,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,0,8,0,0,0,0,0,0,0,0,0,4,4,1,1,1,1,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,4,1,1,1,1,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,4,1,1,1,1,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,1,1,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,4,1,1,1,1,1,1,1,1,1,4,4,4,4,4,14,0,0,0,0,0,14,4,4,4,4,4,1,1,1,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1],
  	[4,0,0,0,4,4,4,4,4,9,-1,9,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,22,-1,4,4,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,0,0,0,4,0,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,0,0,0,0,4,0,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,1,1,1,1],
  	[4,0,0,0,4,0,0,0,4,0,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,2,0,0,0,0,0,0,0,0,0,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,-1,0,0,0,0,0,0,0,0,0,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,2,0,0,0,0,0,0,0,0,0,1,1,1,1],
  	[4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,4,4,4,4,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,1,1,1,1],
  	[4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,0,4,4,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,4,4,4,4,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,4,4,8,0,0,4,0,0,4,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,3,-1,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,4,0,-1,0,0,1,0,0,4,0,4,1,1,1,1,1,1,1,1,0,0,0,0,2,0,0,0,2,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,4,4,8,0,0,0,0,0,4,4,4,1,1,1,1,1,1,1,1,0,0,0,0,-1,0,0,0,-1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,4,4,4,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,0,0,0,0,2,0,0,0,2,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,4,4,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,20,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,4,4,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,19,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,4,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,2,0,0,0,2,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,4,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,-1,0,0,0,-1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,2,0,0,0,2,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,11,1,1,23,1,1,12,1,1,11,1,1,11,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
  ]

  WORLD_TEXTURES = [
    { :north => 'blue1_1.png', :east => 'blue1_2.png', :south => 'blue1_1.png', :west => 'blue1_2.png' },
    { :north => 'door_s_1.png', :east => 'blue1_2.png', :south => 'door_s_1.png', :west => 'blue1_2.png' },
    { :north => 'blue1_1.png', :east => 'door_s_2.png', :south => 'blue1_1.png', :west => 'door_s_2.png' },
    
    { :north => 'grey1_1.png', :east => 'grey1_2.png', :south => 'grey1_1.png', :west => 'grey1_2.png' },
    
    { :north => 'wood1_1.png', :east => 'wood1_2.png', :south => 'wood1_1.png', :west => 'wood1_2.png' },
    { :north => 'door_s_1.png', :east => 'wood1_2.png', :south => 'door_s_1.png', :west => 'wood1_2.png' },
    { :north => 'wood1_1.png', :east => 'door_s_2.png', :south => 'wood1_1.png', :west => 'door_s_2.png' },
    
    { :north => 'door_s_1.png', :east => 'grey1_2.png', :south => 'door_s_1.png', :west => 'grey1_2.png' },
    { :north => 'grey1_1.png', :east => 'door_s_2.png', :south => 'grey1_1.png', :west => 'door_s_2.png' },
    
    { :north => 'wood_php_1.png', :east => 'wood_php_1.png', :south => 'wood_php_1.png', :west => 'wood_php_1.png' },
    { :north => 'blue2_1.png', :east => 'blue1_2.png', :south => 'blue1_1.png', :west => 'blue1_2.png' },
    { :north => 'blue3_1.png', :east => 'blue3_2.png', :south => 'blue3_1.png', :west => 'blue3_2.png' },
    { :north => 'wall_gray_flag.png', :east => 'wall_gray_flag.png', :south => 'wall_gray_flag.png', :west => 'wall_gray_flag.png' },
    { :north => 'wall_wood_hitler.png', :east => 'wall_wood_hitler.png', :south => 'wall_wood_hitler.png', :west => 'wall_wood_hitler.png' },
    
    { :north => 'pratik.png', :east => 'pratik.png', :south => 'pratik.png', :west => 'pratik.png' },
    { :north => 'koz.png', :east => 'koz.png', :south => 'koz.png', :west => 'koz.png' },
    { :north => 'mongrel.png', :east => 'mongrel.png', :south => 'mongrel.png', :west => 'mongrel.png' },
    
    { :north => 'wall_wood_eagle.png', :east => 'wall_wood_eagle.png', :south => 'wall_wood_eagle.png', :west => 'wall_wood_eagle.png' },
    { :north => 'peter_cooper.png', :east => 'peter_cooper.png', :south => 'peter_cooper.png', :west => 'peter_cooper.png' },
    { :north => 'rubyinside.png', :east => 'rubyinside.png', :south => 'rubyinside.png', :west => 'rubyinside.png' },
    { :north => 'joshpeek.png', :east => 'door_s_2.png', :south => 'joshpeek.png', :west => 'door_s_2.png' },
    { :north => 'grey1_1.png', :east => 'grey1_2.png', :south => 'peepcode.png', :west => 'grey1_2.png' },
    { :north => 'antonio.png', :east => 'blue1_2.png', :south => 'antonio.png', :west => 'blue1_2.png' },
    
    { :north => 'door_1.png',  :east => 'door_2.png',  :south => 'door_1.png',  :west => 'door_2.png' },
  ]

  if ARGV[0]
    PLAYER_X = ARGV[0].to_i * Map::GRID_WIDTH_HEIGHT
  else
    PLAYER_X = 29.5 * Map::GRID_WIDTH_HEIGHT
  end
  if ARGV[1]
    PLAYER_Y = ARGV[1].to_i * Map::GRID_WIDTH_HEIGHT
  else
    PLAYER_Y = 57.5 * Map::GRID_WIDTH_HEIGHT
  end
  PLAYER_ANGLE = 0
  
  def self.create(window)
    map = Map.new(MATRIX, WORLD_TEXTURES, PLAYER_X, PLAYER_Y, PLAYER_ANGLE, window)
    map.props = [
      DeadGuard.new(window, 31.5 * Map::GRID_WIDTH_HEIGHT, 57.5 * Map::GRID_WIDTH_HEIGHT),
      Bones.new(window, 40.5 * Map::GRID_WIDTH_HEIGHT, 57.5 * Map::GRID_WIDTH_HEIGHT),
      Bones.new(window, 28.5 * Map::GRID_WIDTH_HEIGHT, 51.5 * Map::GRID_WIDTH_HEIGHT),
      Skeleton.new(window, 38.5 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Skeleton.new(window, 35.5 * Map::GRID_WIDTH_HEIGHT, 33.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 31 * Map::GRID_WIDTH_HEIGHT, 61.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 61.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 38.5 * Map::GRID_WIDTH_HEIGHT, 61.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 58.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 47.0 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 42.0 * Map::GRID_WIDTH_HEIGHT),
      
      Chandelier.new(window, 39.0 * Map::GRID_WIDTH_HEIGHT, 33.0 * Map::GRID_WIDTH_HEIGHT),
      Chandelier.new(window, 34.0 * Map::GRID_WIDTH_HEIGHT, 33.0 * Map::GRID_WIDTH_HEIGHT),
      Chandelier.new(window, 29.0 * Map::GRID_WIDTH_HEIGHT, 33.0 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 27.5 * Map::GRID_WIDTH_HEIGHT, 36.5 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 27.5 * Map::GRID_WIDTH_HEIGHT, 30.5 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 41.5 * Map::GRID_WIDTH_HEIGHT, 30.5 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 41.5 * Map::GRID_WIDTH_HEIGHT, 36.5 * Map::GRID_WIDTH_HEIGHT),
      Flag.new(window, 35.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT),
      Flag.new(window, 33.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT),
      
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 25.0 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 22.0 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 19.0 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 37.0 * Map::GRID_WIDTH_HEIGHT, 22.5 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 32.0 * Map::GRID_WIDTH_HEIGHT, 22.5 * Map::GRID_WIDTH_HEIGHT),
      
      ColonelSanders.new(window, 34.0 * Map::GRID_WIDTH_HEIGHT, 11.0 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.0 * Map::GRID_WIDTH_HEIGHT, 12.0 * Map::GRID_WIDTH_HEIGHT),
      TableWithChairs.new(window, 36.0 * Map::GRID_WIDTH_HEIGHT, 13.5 * Map::GRID_WIDTH_HEIGHT),
      TableWithChairs.new(window, 32.0 * Map::GRID_WIDTH_HEIGHT, 13.0 * Map::GRID_WIDTH_HEIGHT),
    ]
    
    map.items = [
      Food.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 62.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 29.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      PHP.new(window, map, 32.0 * Map::GRID_WIDTH_HEIGHT, 61.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      
      Food.new(window, map, 37.0 * Map::GRID_WIDTH_HEIGHT, 34.5 * Map::GRID_WIDTH_HEIGHT),
      Rails.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 18.5 * Map::GRID_WIDTH_HEIGHT),
      PHP.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 18.5 * Map::GRID_WIDTH_HEIGHT),
      
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 13.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 13.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 14.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 11.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 14.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 14.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 11.5 * Map::GRID_WIDTH_HEIGHT),
      
      Peepcode.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT,
                   "Room of horizontal scaling\nGoal: shutdown pack of Mongrels"),
      Peepcode.new(window, map, 34.0 * Map::GRID_WIDTH_HEIGHT, 51.5 * Map::GRID_WIDTH_HEIGHT,
                   "Room of vertical scaling\nStarring: Thin web server\nWarning: more powerful than a single mongrel!"),
      Peepcode.new(window, map, 31.5 * Map::GRID_WIDTH_HEIGHT, 32.0 * Map::GRID_WIDTH_HEIGHT,
                   "Don't worry Pratik, Koz, I'll free you guys in no time!"),
      Peepcode.new(window, map, 33.5 * Map::GRID_WIDTH_HEIGHT, 17.5 * Map::GRID_WIDTH_HEIGHT,
                   "Josh Peek: \"No, don't go in there! Inside is ZED SHAW!'\"",
                   "enter_zed.ogg"),
    ]
    
    map.players = [
      Guard.new(window, map, 40.5 * Map::GRID_WIDTH_HEIGHT, 61.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 57.5 * Map::GRID_WIDTH_HEIGHT),
      Thin.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 41.5 * Map::GRID_WIDTH_HEIGHT),
      
      Dog.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.5 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.5 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT),
      
      Hans.new(window, map, 31.0 * Map::GRID_WIDTH_HEIGHT, 35.0 * Map::GRID_WIDTH_HEIGHT),
      Hans.new(window, map, 38.0 * Map::GRID_WIDTH_HEIGHT, 31.0 * Map::GRID_WIDTH_HEIGHT),
      
      Hans.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 27.0 * Map::GRID_WIDTH_HEIGHT),
      Hans.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 26.0 * Map::GRID_WIDTH_HEIGHT),
      Hans.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 25.0 * Map::GRID_WIDTH_HEIGHT),
      
      Ronald.new(window, map, 34.0 * Map::GRID_WIDTH_HEIGHT, 9.0 * Map::GRID_WIDTH_HEIGHT),
      Zed.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 9.0 * Map::GRID_WIDTH_HEIGHT),
      Zed.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 9.0 * Map::GRID_WIDTH_HEIGHT),
    ]
    
    map
  end
end