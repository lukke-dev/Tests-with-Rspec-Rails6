class Weapon < ApplicationRecord
  validates :name, length: { in: 3..25 }
  def current_power
    power_base + ((level - 1) * power_step)
  end

  def title
    "#{name} ##{level}"
  end
end
