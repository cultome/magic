class Magic::Player
  attr_reader :lives, :mana_pool, :library, :hand, :graveyard, :battlefield

  def initialize(library:)
    @lives = 20
    @mana_pool = Magic::ManaPool.new
    @library = library
    @hand = Magic::Hand.new
    @graveyard = Magic::Graveyard.new
    @battlefield = Magic::Battlefield.new
  end

  def draw(count = 1)
    drawed_card = library.pop
    hand.add drawed_card
  end

  def play(card)
    raise 'The card is not in your hand!' unless hand.include? card
    raise 'Dont have enough mana!' unless mana_pool.has? card.mana_cost

    mana_pool.consume card.mana_cost

    # execute card specific on_play effects
    Magic::Ability::Repository.on_play card

    hand.remove card
    battlefield.enter card
  end
end
