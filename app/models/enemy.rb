class Enemy < ApplicationRecord
  enum kind: %i[goblin orc demon dragon]
  validates :level, numericality: { greater_than: 0, less_than_or_equal: 99 }
  validates_presence_of :name, :power_base, :power_step, :level, :kind

  def current_power
    power_base + ((level - 1) * power_step)
  end
end
