module Magic::Game::Context
  attr_reader :context

  def set_game_context(owner:, enemy:, battlefield:, graveyard:, library:, hand:)
    @context = OpenStruct.new(owner:, enemy:, battlefield:, graveyard:, library:, hand:)
  end
end
