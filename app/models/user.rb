class User < ApplicationRecord
  enum kind: %i[knight wizard]
  validates :level, numericality: { greater_than: 0, less_than: 100 }

  def title
    "#{kind} #{nickname} ##{level}"
  end
end
