class Magic::Card
  include Magic::Game::Context
  include Magic::Game::Eventable
  include Magic::Ability::Passive::Tappable

  attr_reader :name, :supertype, :subtype, :mana_cost, :abilities, :toughness, :power, :expansion, :rarity, :illustration, :flavor_text,
:artist, :collector_number

  def initialize(
    name:,
    supertype:,
    subtype:,
    mana_cost:,
    abilities:,
    toughness: 0,
    power: 0,
    expansion: nil,
    rarity: nil,
    illustration: '',
    flavor_text: '',
    artist: '',
    collector_number: 0
  )
    @name = name
    @supertype = supertype
    @subtype = subtype
    @mana_cost = mana_cost
    @abilities = abilities
    @toughness = toughness
    @power = power
    @expansion = expansion
    @rarity = rarity
    @illustration = illustration
    @flavor_text = flavor_text
    @artist = artist
    @collector_number = collector_number
  end
end
