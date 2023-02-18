class Magic::ManaCost
  extend Forwardable
  include Enumerable

  def_delegator :@cost_by_color, :each, :each

  attr_reader :cost_by_color

  def self.from(expression)
    cost = expression.scan(/\d\w/).each_with_object({}) do |cost_by_color, acc|
      color = case cost_by_color[1]
              when 'C' then :colorless
              when 'R' then :red
              when 'B' then :blue
              when 'W' then :white
              when 'K' then :black
              when 'G' then :green
              end

      acc[color] = cost_by_color[0].to_i
    end

    Magic::ManaCost.new cost
  end

  def initialize(cost_by_color)
    @cost_by_color = cost_by_color
  end

  def colorless
    cost_by_color.fetch(:colorless, 0)
  end

  def red
    cost_by_color.fetch(:red, 0)
  end

  def blue
    cost_by_color.fetch(:blue, 0)
  end

  def white
    cost_by_color.fetch(:white, 0)
  end

  def black
    cost_by_color.fetch(:black, 0)
  end

  def green
    cost_by_color.fetch(:green, 0)
  end
end
