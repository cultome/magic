class Magic::GameContext::Context
  attr_reader :owner, :enemy, :battlefield, :graveyard, :library, :hand

  def initialize(owner:, enemy:, battlefield:, graveyard:, library:, hand:)
    @owner = owner
    @enemy = enemy
    @battlefield = battlefield
    @graveyard = graveyard
    @library = library
    @hand = hand
  end
end
