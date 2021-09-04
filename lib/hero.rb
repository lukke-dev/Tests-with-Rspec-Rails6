class Hero
  attr_accessor :weapon, :hp

  def initialize
    @weapon = 'sword'
    @hp = 1200
  end

  def title
    "#{kind} #{nickname} ##{level}"
  end
end
