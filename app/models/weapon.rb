class Weapon
  attr_accessor :level, :name, :description, :power_base, :power_step

  def initialize
    @level = 1
  end

  def current_power
    power_base + ((level - 1) * power_step)
  end

  def title
    "#{name} ##{level}"
  end
end
