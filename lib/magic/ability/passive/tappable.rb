module Magic::Ability::Passive::Tappable
  def tapped?
    @tapped
  end

  def tap!
    raise 'Already tapped' if tapped?
    raise 'Not enough mana' unless context.owner.mana_pool.has?(mana_cost)

    context.owner.mana_pool.consume mana_cost

    @tapped = true
  end

  def untap!
    @tapped = false
  end
end
