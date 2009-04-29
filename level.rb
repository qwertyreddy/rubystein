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
  	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,5,18,5,5,5,5,5,18,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,4,4,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,4,1,1,1,1,1,1,4,4,4,4,4,4,4,13,4,4,4,18,0,0,0,0,0,0,0,0,0,0,0,18,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,4,4,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,4,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,4,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,4,24,4,4,25,4,4,24,4,4,1,4,0,0,0,4,4,4,13,4,4,4,14,0,0,0,0,0,0,0,0,0,0,0,14,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,4,1,4,0,0,0,4,1,1,1,1,1,1,5,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,13,0,0,0,0,0,0,0,0,0,13,4,4,0,0,0,4,4,4,1,1,1,1,5,5,5,18,5,21,-1,7,5,18,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4,1,1,1,1,5,5,5,5,5,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[1,1,1,1,1,4,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,4,1,1,1,1,1,1,5,5,5,0,0,0,5,5,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4,1,1,1,1,1,1,5,5,14,0,0,0,14,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,4,4,4,4,13,0,0,0,0,0,0,0,0,0,13,4,4,4,24,4,4,4,1,1,1,1,1,1,1,5,5,5,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,0,0,0,0,0,0,0,0,0,4,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,24,4,9,-1,9,4,24,4,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,4,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,0,0,0,0,0,0,0,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,9,-1,9,4,4,4,4,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,4,4,4,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,4,0,0,0,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,0,0,5,5,5,0,0,0,5,5,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  	[4,0,0,0,0,0,0,0,4,0,0,0,4,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,18,0,0,0,18,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
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
    
    # 8
    { :north => 'door_s_1.png', :east => 'grey1_2.png', :south => 'door_s_1.png', :west => 'grey1_2.png' },
    { :north => 'grey1_1.png', :east => 'door_s_2.png', :south => 'grey1_1.png', :west => 'door_s_2.png' },
    
    # 10
    { :north => 'wood_php_1.png', :east => 'wood_php_1.png', :south => 'wood_php_1.png', :west => 'wood_php_1.png' },
    { :north => 'blue2_1.png', :east => 'blue1_2.png', :south => 'blue1_1.png', :west => 'blue1_2.png' },
    { :north => 'blue3_1.png', :east => 'blue3_2.png', :south => 'blue3_1.png', :west => 'blue3_2.png' },
    { :north => 'wall_gray_flag.png', :east => 'wall_gray_flag.png', :south => 'wall_gray_flag.png', :west => 'wall_gray_flag.png' },
    { :north => 'wall_wood_hitler.png', :east => 'wall_wood_hitler.png', :south => 'wall_wood_hitler.png', :west => 'wall_wood_hitler.png' },
    
    # 15
    { :north => 'pratik.png', :east => 'pratik.png', :south => 'pratik.png', :west => 'pratik.png' },
    { :north => 'koz.png', :east => 'koz.png', :south => 'koz.png', :west => 'koz.png' },
    { :north => 'yoda.png', :east => 'yoda.png', :south => 'yoda.png', :west => 'yoda.png' },
    
    # 18
    { :north => 'wall_wood_eagle.png', :east => 'wall_wood_eagle.png', :south => 'wall_wood_eagle.png', :west => 'wall_wood_eagle.png' },
    { :north => 'peter_cooper.png', :east => 'peter_cooper.png', :south => 'peter_cooper.png', :west => 'peter_cooper.png' },
    { :north => 'rubyinside.png', :east => 'rubyinside.png', :south => 'rubyinside.png', :west => 'rubyinside.png' },
    { :north => 'joshpeek.png', :east => 'door_s_2.png', :south => 'joshpeek.png', :west => 'door_s_2.png' },
    { :north => 'grey1_1.png', :east => 'grey1_2.png', :south => 'peepcode.png', :west => 'grey1_2.png' },
    { :north => 'antonio.png', :east => 'blue1_2.png', :south => 'antonio.png', :west => 'blue1_2.png' },
    
    # 24
    { :north => 'wall_gray_eagle.png', :east => 'wall_gray_eagle.png', :south => 'wall_gray_eagle.png', :west => 'wall_gray_eagle.png' },
    { :north => 'wall_gray_hitler.png', :east => 'wall_gray_hitler.png', :south => 'wall_gray_hitler.png', :west => 'wall_gray_hitler.png' },
    
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
      # Southern (starting) room.
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
      
      # Central room.
      Chandelier.new(window, 39.0 * Map::GRID_WIDTH_HEIGHT, 33.0 * Map::GRID_WIDTH_HEIGHT),
      Chandelier.new(window, 34.0 * Map::GRID_WIDTH_HEIGHT, 33.0 * Map::GRID_WIDTH_HEIGHT),
      Chandelier.new(window, 29.0 * Map::GRID_WIDTH_HEIGHT, 33.0 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 27.5 * Map::GRID_WIDTH_HEIGHT, 36.5 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 27.5 * Map::GRID_WIDTH_HEIGHT, 30.5 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 41.5 * Map::GRID_WIDTH_HEIGHT, 30.5 * Map::GRID_WIDTH_HEIGHT),
      GreenPlant.new(window, 41.5 * Map::GRID_WIDTH_HEIGHT, 36.5 * Map::GRID_WIDTH_HEIGHT),
      Flag.new(window, 35.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT),
      Flag.new(window, 33.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT),
      
      # Eastern room.
      Table.new(window, 56.5 * Map::GRID_WIDTH_HEIGHT, 35.5 * Map::GRID_WIDTH_HEIGHT),
      Table.new(window, 59.5 * Map::GRID_WIDTH_HEIGHT, 35.5 * Map::GRID_WIDTH_HEIGHT),
      Well.new(window, 56.5 * Map::GRID_WIDTH_HEIGHT, 38.5 * Map::GRID_WIDTH_HEIGHT),
      Well.new(window, 59.5 * Map::GRID_WIDTH_HEIGHT, 38.5 * Map::GRID_WIDTH_HEIGHT),
      BrownBarrel.new(window, 61.5 * Map::GRID_WIDTH_HEIGHT, 30.5 * Map::GRID_WIDTH_HEIGHT),
      BrownBarrel.new(window, 61.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT),
      BrownBarrel.new(window, 60.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT),
      BrownBarrel.new(window, 59.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT),
      
      ColonelSanders.new(window, 56.5 * Map::GRID_WIDTH_HEIGHT, 44.5 * Map::GRID_WIDTH_HEIGHT),
      TableWithChairs.new(window, 55.5 * Map::GRID_WIDTH_HEIGHT, 45.5 * Map::GRID_WIDTH_HEIGHT),
      TableWithChairs.new(window, 55.5 * Map::GRID_WIDTH_HEIGHT, 43.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 54.5 * Map::GRID_WIDTH_HEIGHT, 44.5 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 52.5 * Map::GRID_WIDTH_HEIGHT, 42.5 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 52.5 * Map::GRID_WIDTH_HEIGHT, 46.5 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 54.5 * Map::GRID_WIDTH_HEIGHT, 42.5 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 54.5 * Map::GRID_WIDTH_HEIGHT, 46.5 * Map::GRID_WIDTH_HEIGHT),
      
      # Path to northern room.
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 25.0 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 22.0 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 34.5 * Map::GRID_WIDTH_HEIGHT, 19.0 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 37.0 * Map::GRID_WIDTH_HEIGHT, 22.5 * Map::GRID_WIDTH_HEIGHT),
      Armor.new(window, 32.0 * Map::GRID_WIDTH_HEIGHT, 22.5 * Map::GRID_WIDTH_HEIGHT),
      
      # Northern room.
      Lamp.new(window, 34.0 * Map::GRID_WIDTH_HEIGHT, 12.0 * Map::GRID_WIDTH_HEIGHT),
      TableWithChairs.new(window, 36.0 * Map::GRID_WIDTH_HEIGHT, 9.5 * Map::GRID_WIDTH_HEIGHT),
      TableWithChairs.new(window, 32.0 * Map::GRID_WIDTH_HEIGHT, 9.5 * Map::GRID_WIDTH_HEIGHT),
      Vase.new(window, 29.5 * Map::GRID_WIDTH_HEIGHT, 8.5 * Map::GRID_WIDTH_HEIGHT),
      Vase.new(window, 39.5 * Map::GRID_WIDTH_HEIGHT, 8.5 * Map::GRID_WIDTH_HEIGHT),
      
      Lamp.new(window, 24.5 * Map::GRID_WIDTH_HEIGHT, 11.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 19.5 * Map::GRID_WIDTH_HEIGHT, 11.5 * Map::GRID_WIDTH_HEIGHT),
      Lamp.new(window, 19.5 * Map::GRID_WIDTH_HEIGHT, 17.5 * Map::GRID_WIDTH_HEIGHT),
    ]
    
    map.items = [
      # Southern (starting) room.
      Food.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 62.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 29.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      PHP.new(window, map, 32.0 * Map::GRID_WIDTH_HEIGHT, 61.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Info.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 62.2 * Map::GRID_WIDTH_HEIGHT,
               "AkitaOnRails: \"OMG HELP MEE! DUN WANNA DIE!!11\""),
      Info.new(window, map, 31.5 * Map::GRID_WIDTH_HEIGHT, 62.2 * Map::GRID_WIDTH_HEIGHT,
               "Antonio Cangiano: \"Now on sale: Ruby on\nRails for Microsoft Developers\""),
      Info.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 55.5 * Map::GRID_WIDTH_HEIGHT,
               "Peter Cooper: \"You are our last hope.\nShow the people that Rails CAN scale!\""),
      Info.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT,
               "Room of horizontal scaling\nGoal: shutdown pack of Mongrels"),
      Info.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 51.5 * Map::GRID_WIDTH_HEIGHT,
               "Room of vertical scaling\nStarring: Thin web server\nWarning: more powerful than a single mongrel!"),
      
      # Central room with Pratik, Koz and Yoda.
      Peepcode.new(window, map, 37.0 * Map::GRID_WIDTH_HEIGHT, 34.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 35.0 * Map::GRID_WIDTH_HEIGHT),
      Info.new(window, map, 32.0 * Map::GRID_WIDTH_HEIGHT, 32.0 * Map::GRID_WIDTH_HEIGHT,
               "Don't worry Pratik, Koz, I'll free you guys in no time!"),
      InvisibleInfo.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 29.5 * Map::GRID_WIDTH_HEIGHT) { |item, player|
          if player.max_health < 150
            window.show_text('Yoda: "Wait, young hero. Do not go in there yet!"')
          else
            window.show_text('Yoda: "Go, young hero. May the source be with you."')
          end
        },
      Info.new(window, map, 36.5 * Map::GRID_WIDTH_HEIGHT, 32.5 * Map::GRID_WIDTH_HEIGHT) { |item, player|
          if player.max_health < 150
            window.show_text("Yoda: \"Strong enough to defeat the enemy, you are not.\n" +
              "Train yourself in the room east of here, you must!\"")
          else
            window.show_text("Yoda: \"Trained well, you have, young hero!\"")
          end
        },
      
      Rails.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 18.5 * Map::GRID_WIDTH_HEIGHT),
      PHP.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 18.5 * Map::GRID_WIDTH_HEIGHT),
      Info.new(window, map, 33.5 * Map::GRID_WIDTH_HEIGHT, 17.5 * Map::GRID_WIDTH_HEIGHT,
               "Josh Peek: \"No, don't go in there! Inside is ZED SHAW!'\""),
      InvisibleInfo.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 16.5 * Map::GRID_WIDTH_HEIGHT,
                        nil, "enter_zed.ogg"),
      
      # Eastern room.
      Peepcode.new(window, map, 51.5 * Map::GRID_WIDTH_HEIGHT, 34.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 58.5 * Map::GRID_WIDTH_HEIGHT, 30.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 56.5 * Map::GRID_WIDTH_HEIGHT, 34.5 * Map::GRID_WIDTH_HEIGHT),
      Phusion.new(window, map, 59.5 * Map::GRID_WIDTH_HEIGHT, 36.5 * Map::GRID_WIDTH_HEIGHT, 150),
      
      Food.new(window, map, 55.5 * Map::GRID_WIDTH_HEIGHT, 44.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 54.5 * Map::GRID_WIDTH_HEIGHT, 43.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 55.0 * Map::GRID_WIDTH_HEIGHT, 45.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 54.5 * Map::GRID_WIDTH_HEIGHT, 45.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 55.0 * Map::GRID_WIDTH_HEIGHT, 43.5 * Map::GRID_WIDTH_HEIGHT),
      InvisibleInfo.new(window, map, 54.5 * Map::GRID_WIDTH_HEIGHT, 33.5 * Map::GRID_WIDTH_HEIGHT) { |item, player|
          if player.max_health >= 150 && !@power_150_felt
            @power_150_felt = true
            window.show_text("I can feel it... THE POWER!!!")
            item.play_sound = true
          else
            # Hack: force interaction.
            item.instance_variable_set(:@last_interaction_time, 0)
            item.play_sound = false
          end
        },
      InvisibleInfo.new(window, map, 52.5 * Map::GRID_WIDTH_HEIGHT, 33.5 * Map::GRID_WIDTH_HEIGHT) { |item, player|
          window.show_text("Fighting makes me hungry.") if !@eaten_at_kfc
          item.play_sound = !@eaten_at_kfc
        },
      InvisibleInfo.new(window, map, 49.9 * Map::GRID_WIDTH_HEIGHT, 44.5 * Map::GRID_WIDTH_HEIGHT) { |item, player|
          window.show_text("Is there anything to eat?") if !@eaten_at_kfc
          item.play_sound = !@eaten_at_kfc
        },
      InvisibleInfo.new(window, map, 51.5 * Map::GRID_WIDTH_HEIGHT, 44.5 * Map::GRID_WIDTH_HEIGHT) { |item, player|
          @eaten_at_kfc = true
          item.play_sound = false
        },
      
      # Northern room.
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 13.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 13.0 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 14.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 11.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 14.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 14.5 * Map::GRID_WIDTH_HEIGHT),
      Food.new(window, map, 35.5 * Map::GRID_WIDTH_HEIGHT, 11.5 * Map::GRID_WIDTH_HEIGHT),
      Phusion.new(window, map, 30.0 * Map::GRID_WIDTH_HEIGHT, 10.0 * Map::GRID_WIDTH_HEIGHT, 200),
      InvisibleInfo.new(window, map, 29.5 * Map::GRID_WIDTH_HEIGHT, 11.5 * Map::GRID_WIDTH_HEIGHT,
                        "Those weren't Zed Shaws, they're too weak.\n" +
                        "The real one must be hiding somewhere!",
                        "getthem.mp3"),
      
      # Path to west room.
      Peepcode.new(window, map, 19.5 * Map::GRID_WIDTH_HEIGHT, 10.5 * Map::GRID_WIDTH_HEIGHT),
      Rails.new(window, map, 20.5 * Map::GRID_WIDTH_HEIGHT, 18.5 * Map::GRID_WIDTH_HEIGHT),
    ]
    
    map.players = [
      # Southern (starting) room.
      Guard.new(window, map, 40.5 * Map::GRID_WIDTH_HEIGHT, 61.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 57.5 * Map::GRID_WIDTH_HEIGHT),
      Thin.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 41.5 * Map::GRID_WIDTH_HEIGHT),
      
      # Room of horizontal scaling.
      Dog.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.5 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 52.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.0 * Map::GRID_WIDTH_HEIGHT, 52.0 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 38.5 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT),
      Dog.new(window, map, 39.0 * Map::GRID_WIDTH_HEIGHT, 53.5 * Map::GRID_WIDTH_HEIGHT),
      
      # Central room with Pratik, Koz and Yoda.
      Hans.new(window, map, 31.0 * Map::GRID_WIDTH_HEIGHT, 35.0 * Map::GRID_WIDTH_HEIGHT),
      Hans.new(window, map, 38.0 * Map::GRID_WIDTH_HEIGHT, 31.0 * Map::GRID_WIDTH_HEIGHT),
      
      # Eastern room.
      Guard.new(window, map, 49.5 * Map::GRID_WIDTH_HEIGHT, 33.5 * Map::GRID_WIDTH_HEIGHT),
      Hans.new(window, map, 47.5 * Map::GRID_WIDTH_HEIGHT, 40.5 * Map::GRID_WIDTH_HEIGHT),
      Thin.new(window, map, 49.5 * Map::GRID_WIDTH_HEIGHT, 44.5 * Map::GRID_WIDTH_HEIGHT),
      Thin.new(window, map, 59.5 * Map::GRID_WIDTH_HEIGHT, 31.5 * Map::GRID_WIDTH_HEIGHT),
      Thin.new(window, map, 60.5 * Map::GRID_WIDTH_HEIGHT, 36.5 * Map::GRID_WIDTH_HEIGHT),
      
      # Path to north room.
      Hans.new(window, map, 32.0 * Map::GRID_WIDTH_HEIGHT, 22.0 * Map::GRID_WIDTH_HEIGHT),
      Guard.new(window, map, 34.5 * Map::GRID_WIDTH_HEIGHT, 26.0 * Map::GRID_WIDTH_HEIGHT),
      Hans.new(window, map, 37.0 * Map::GRID_WIDTH_HEIGHT, 22.0 * Map::GRID_WIDTH_HEIGHT),
      
      # North room.
      Ronald.new(window, map, 42.0 * Map::GRID_WIDTH_HEIGHT, 11.0 * Map::GRID_WIDTH_HEIGHT),
      Ronald.new(window, map, 43.0 * Map::GRID_WIDTH_HEIGHT, 12.0 * Map::GRID_WIDTH_HEIGHT),
      Zed.new(window, map, 37.5 * Map::GRID_WIDTH_HEIGHT, 9.0 * Map::GRID_WIDTH_HEIGHT),
      Zed.new(window, map, 32.5 * Map::GRID_WIDTH_HEIGHT, 9.0 * Map::GRID_WIDTH_HEIGHT),
      
      Guard.new(window, map, 22.5 * Map::GRID_WIDTH_HEIGHT, 11.0 * Map::GRID_WIDTH_HEIGHT),
      Guard.new(window, map, 24.5 * Map::GRID_WIDTH_HEIGHT, 12.0 * Map::GRID_WIDTH_HEIGHT),
      Guard.new(window, map, 19.5 * Map::GRID_WIDTH_HEIGHT, 15.0 * Map::GRID_WIDTH_HEIGHT),
      Guard.new(window, map, 22.5 * Map::GRID_WIDTH_HEIGHT, 17.5 * Map::GRID_WIDTH_HEIGHT),
      Hans.new(window, map, 17.5 * Map::GRID_WIDTH_HEIGHT, 17.0 * Map::GRID_WIDTH_HEIGHT),
      
      TrueZed.new(window, map, 10.0 * Map::GRID_WIDTH_HEIGHT, 17.0 * Map::GRID_WIDTH_HEIGHT),
    ]
    
    map
  end
end