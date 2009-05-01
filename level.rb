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
    { :north => 'wall_wood_tux.png', :east => 'wall_wood_tux.png', :south => 'wall_wood_tux.png', :west => 'wall_wood_tux.png' },
    
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
    { :north => 'wall_gray_tux.png', :east => 'wall_gray_tux.png', :south => 'wall_gray_tux.png', :west => 'wall_gray_tux.png' },
    
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
    
    # Preload MagicPony so that it loads quickly next time.
    MagicPony.new(window, 0, 0)
    
    ####### Props #######
    
    # Southern (starting) room.
    map.add do |add|
      add.prop(DeadGuard, 31.5, 57.5)
      add.prop(Bones, 40.5, 57.5)
      add.prop(Bones, 28.5, 51.5)
      add.prop(Skeleton, 38.5, 52.5)
      add.prop(Skeleton, 35.5, 33.5)
      add.prop(Lamp, 31, 61.5)
      add.prop(Lamp, 34.5, 61.5)
      add.prop(Lamp, 38.5, 61.5)
      add.prop(Lamp, 34.5, 53.5)
      add.prop(Lamp, 34.5, 58.5)
      add.prop(Lamp, 34.5, 47.0)
      add.prop(Lamp, 34.5, 42.0)
      
      # Central room.
      add.prop(Chandelier, 39.0, 33.0)
      add.prop(Chandelier, 34.0, 33.0)
      add.prop(Chandelier, 29.0, 33.0)
      add.prop(GreenPlant, 27.5, 36.5)
      add.prop(GreenPlant, 27.5, 30.5)
      add.prop(GreenPlant, 41.5, 30.5)
      add.prop(GreenPlant, 41.5, 36.5)
      add.prop(Flag, 35.5, 29.5)
      add.prop(Flag, 33.5, 29.5)
      
      # Eastern room.
      add.prop(Table, 56.5, 35.5)
      add.prop(Table, 59.5, 35.5)
      add.prop(Well, 56.5, 38.5)
      add.prop(Well, 59.5, 38.5)
      add.prop(BrownBarrel, 61.5, 30.5)
      add.prop(BrownBarrel, 61.5, 29.5)
      add.prop(BrownBarrel, 60.5, 29.5)
      add.prop(BrownBarrel, 59.5, 29.5)
      
      add.prop(ColonelSanders, 56.5, 44.5)
      add.prop(TableWithChairs, 55.5, 45.5)
      add.prop(TableWithChairs, 55.5, 43.5)
      add.prop(Lamp, 54.5, 44.5)
      add.prop(Armor, 52.5, 42.5)
      add.prop(Armor, 52.5, 46.5)
      add.prop(Armor, 54.5, 42.5)
      add.prop(Armor, 54.5, 46.5)
      
      # Path to northern room.
      add.prop(Lamp, 34.5, 25.0)
      add.prop(Lamp, 34.5, 22.0)
      add.prop(Lamp, 34.5, 19.0)
      add.prop(Armor, 37.0, 22.5)
      add.prop(Armor, 32.0, 22.5)
      
      # Northern room.
      add.prop(Lamp, 34.0, 12.0)
      add.prop(TableWithChairs, 36.0, 9.5)
      add.prop(TableWithChairs, 32.0, 9.5)
      add.prop(Vase, 29.5, 8.5)
      add.prop(Vase, 39.5, 8.5)
      
      add.prop(Lamp, 24.5, 11.5)
      add.prop(Lamp, 19.5, 11.5)
      add.prop(Lamp, 19.5, 17.5)
    end
    
    ####### Players #######
    
    zed1, zed2 = nil
    map.add do |add|
      # Southern (starting) room.
      add.player(Guard, 40.5, 61.5)
      add.player(Dog, 37.5, 57.5)
      add.player(Thin, 34.5, 41.5)
      
      # Room of horizontal scaling.
      add.player(Dog, 37.5, 52.5)
      add.player(Dog, 38.0, 52.0)
      add.player(Dog, 38.5, 52.5)
      add.player(Dog, 39.0, 52.5)
      add.player(Dog, 37.5, 53.5)
      add.player(Dog, 38.0, 52.0)
      add.player(Dog, 38.5, 53.5)
      add.player(Dog, 39.0, 53.5)
      
      # Central room with Pratik, Koz and Yoda.
      add.player(Hans, 31.0, 35.0)
      add.player(Hans, 38.0, 31.0)
      
      # Eastern room.
      add.player(Guard, 49.5, 33.5)
      add.player(Hans, 47.5, 40.5)
      add.player(Thin, 49.5, 44.5)
      add.player(Hongli, 59.5, 31.5)
      add.player(Ninh, 58.5, 35.5)
      
      # Path to north room.
      add.player(Hans, 32.0, 22.0)
      add.player(Guard, 34.5, 26.0)
      add.player(Hans, 37.0, 22.0)
      
      # North room.
      add.player(Ronald, 42.0, 11.0)
      add.player(Ronald, 43.0, 12.0)
      zed1 = add.player(Zed, 37.5, 9.0)
      zed1.active = false
      zed2 = add.player(Zed, 32.5, 9.0)
      zed2.active = false
      
      add.player(Guard, 22.5, 11.0)
      add.player(Guard, 24.5, 12.0)
      add.player(Guard, 19.5, 15.0)
      add.player(Guard, 22.5, 17.5)
      add.player(Hans, 17.5, 17.0)
      add.player(Thin, 22.5, 18.0)
      
      add.player(Hongli, 10.0, 17.0)
      add.player(Ninh, 10.0, 17.0)
    end
    
    ####### Items #######
    
    map.add do |add|
      # Southern (starting) room.
      add.item(Food, 37.5, 62.5)
      add.item(Food, 29.0, 52.0)
      add.item(PHP,  32.0, 61.0)
      add.item(Food, 39.0, 52.0)
      add.item(Food, 39.0, 52.5)
      add.item(Info, 34.5, 62.2, "AkitaOnRails: \"OMG HELP MEE! DUN WANNA DIE!!11\"")
      add.item(Info, 31.5, 62.2, "Antonio Cangiano: \"Now on sale: Ruby on\nRails for Microsoft Developers\"")
      add.item(Info, 35.5, 55.5, "Peter Cooper: \"You are our last hope.\nShow the people that Rails CAN scale!\"")
      add.item(Info, 35.5, 52.5, "Room of horizontal scaling\nGoal: shutdown pack of Mongrels")
      add.item(Info, 34.5, 51.5, "Room of vertical scaling\nStarring: Thin web server\nWarning: more powerful than a single mongrel!")
      
      # Central room with Pratik, Koz and Yoda.
      add.item(Peepcode, 37.0, 34.5)
      add.item(Food, 32.5, 35.0)
      add.item(Info, 32.0, 32.0, "Don't worry Pratik, Koz, I'll free you guys in no time!")
      add.item(InvisibleInfo, 34.5, 29.5) do |item, player|
        if player.max_health < 150
          window.show_text('Yoda: "Wait, young hero. Do not go in there yet!"')
        else
          window.show_text('Yoda: "Go, young hero. May the source be with you."')
        end
      end
      add.item(Info, 36.5, 32.5) do |item, player|
        if player.max_health < 150
          window.show_text("Yoda: \"Strong enough to defeat the enemy, you are not.\n" +
            "Train yourself in the room east of here, you must!\"")
        else
          window.show_text("Yoda: \"Trained well, you have, young hero!\"")
        end
      end
      
      add.item(Rails, 34.5, 18.5)
      add.item(PHP, 35.5, 18.5)
      add.item(Info, 33.5, 17.5, "Josh Peek: \"No, don't go in there! Inside is ZED SHAW!'\"")
      add.item(InvisibleInfo, 34.5, 16.5, nil, "enter_zed.ogg")
      add.item(InvisibleInfo, 34.5, 14.5) do |item, player|
        window.present_boss("Zed Shaw", "rockzed_large.png")
        map.items.delete(item)
        zed1.active = true
        zed2.active = true
      end
      
      # Eastern room.
      add.item(Peepcode, 51.5, 34.5)
      add.item(Peepcode, 58.5, 30.5)
      add.item(Food, 57.5, 30.5)
      add.item(Peepcode, 56.5, 34.5)
      add.item(Phusion, 59.5, 36.5, 150)
      
      add.item(Food, 55.5, 44.5)
      add.item(Food, 54.5, 43.5)
      add.item(Food, 55.0, 45.5)
      add.item(Food, 54.5, 45.5)
      add.item(Food, 55.0, 43.5)
      add.item(InvisibleInfo, 44.5, 33.5) do |item, player|
        if player.max_health >= 150 && !@power_150_felt
          @power_150_felt = true
          window.show_text("I can feel it... THE POWER!!!")
          item.play_sound = true
        else
          # Hack: force interaction.
          item.instance_variable_set(:@last_interaction_time, 0)
          item.play_sound = false
        end
      end
      add.item(InvisibleInfo, 52.5, 33.5) do |item, player|
        window.show_text("Fighting makes me hungry.") if !@eaten_at_kfc
        item.play_sound = !@eaten_at_kfc
      end
      add.item(InvisibleInfo, 54.5, 33.5) do |item, player|
        window.present_boss("Hongli Lai & Ninh Bui", "phusion_guys.png")
        map.items.delete(item)
      end
      add.item(InvisibleInfo, 49.9, 44.5) do |item, player|
        window.show_text("Is there anything to eat?") if !@eaten_at_kfc
        item.play_sound = !@eaten_at_kfc
      end
      add.item(InvisibleInfo, 51.5, 44.5) do |item, player|
        @eaten_at_kfc = true
        item.play_sound = false
      end
      
      # Northern room.
      add.item(Food, 32.5, 13.0)
      add.item(Food, 35.5, 13.0)
      add.item(Food, 32.5, 14.5)
      add.item(Food, 32.5, 11.5)
      add.item(Food, 32.5, 14.5)
      add.item(Food, 35.5, 14.5)
      add.item(Food, 35.5, 11.5)
      add.item(Phusion, 30.0, 10.0, 200)
      add.item(InvisibleInfo, 29.5, 11.5,
        "My god, if even Zed is involved in this\n" +
        "then who's the mastermind?",
        "getthem.mp3")
      
      # Path to west room.
      add.item(Peepcode, 19.5, 10.5)
      add.item(Rails, 20.5, 18.5)
    end
    
    map
  end
end