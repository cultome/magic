module Magic::Game::Context
  attr_reader :context

  def set_game_context(owner:, enemy:, turn:)
    @context = OpenStruct.new(
      owner:,
      enemy:,
      turn:,
      battlefield: owner.battlefield,
      graveyard: owner.graveyard,
      library: owner.library,
      hand: owner.hand,
    )
  end
end
