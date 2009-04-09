module Damageable
  attr_accessor :health
  
  def take_damage_from(player)
    @health -= 5
    #@health -= player.weapon.damage
  end
  
  def die
  end
end