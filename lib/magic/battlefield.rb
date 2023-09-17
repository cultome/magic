class Magic::Battlefield
  extend Forwardable

  attr_reader :cards

  def_delegators :@cards, :empty?, :size, :include?

  def initialize
    @cards = []
  end

  def enter(card)
    @cards << card

    Magic::Game::Event::Register.process_event Magic::Game::Event::CardPlayed.new(card)
  end
end
