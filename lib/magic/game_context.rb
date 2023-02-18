module Magic::GameContext
  attr_reader :context

  def set_game_context(owner:, enemy:, battlefield:, graveyard:, library:, hand:)
    @context = Magic::GameContext::Context.new(owner:, enemy:, battlefield:, graveyard:, library:, hand:)
  end
end

require_relative './game_context/context'
