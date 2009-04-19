module Damageable
  attr_accessor :health
  
  def dead?
    @health <= 0
  end
  
  def take_damage_from(player)
    @health -= 5
    #@health -= player.weapon.damage
  end
end