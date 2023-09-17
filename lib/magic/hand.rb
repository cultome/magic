class Magic::Hand
  extend Forwardable

  attr_reader :cards

  def_delegators :@cards, :empty?, :size, :include?

  def initialize
    @cards = []
  end

  def remove(card)
    hand_idx = cards.index card
    hand_card = cards.delete_at hand_idx

    Magic::Game::Event::Register.process_event Magic::Game::Event::HandCardRemoved.new(hand_card)
  end

  def add(card)
    @cards << card
    Magic::Game::Event::Register.process_event Magic::Game::Event::HandCardAdded.new(card)
  end
end
