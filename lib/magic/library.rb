class Magic::Library
  extend Forwardable

  attr_reader :cards

  def_delegators :@cards, :empty?, :size, :pop, :push, :include?, :delete_at, :index

  def initialize(cards:)
    @cards = cards
  end
end
