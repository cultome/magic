class Magic::ManaPool
  attr_reader :mana_by_color

  def initialize(initial = {})
    @mana_by_color = {
      colorless: initial.fetch(:colorless, 0),
      red: initial.fetch(:red, 0),
      blue: initial.fetch(:blue, 0),
      white: initial.fetch(:white, 0),
      black: initial.fetch(:black, 0),
      green: initial.fetch(:green, 0),
    }
  end

  def has?(mana_cost)
    mana_cost.all? { |color, cost| mana_by_color[color] >= cost }
  end

  def add!(mana_by_color_to_add)
    mana_by_color_to_add.each do |color, count|
      mana_by_color[color] += count
    end
  end

  def colorless
    mana_by_color.fetch(:colorless, 0)
  end

  def red
    mana_by_color.fetch(:red, 0)
  end

  def blue
    mana_by_color.fetch(:blue, 0)
  end

  def white
    mana_by_color.fetch(:white, 0)
  end

  def black
    mana_by_color.fetch(:black, 0)
  end

  def green
    mana_by_color.fetch(:green, 0)
  end
end
