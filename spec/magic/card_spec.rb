RSpec.describe Magic::Card do
  it 'build a card' do
    shivan_dragon = described_class.new(
      name: 'Shivan Dragon',
      supertype: 'Creature',
      subtype: 'Dragon',
      mana_cost: Magic::ManaCost.from('4C2R'),
      abilities: [Magic::Ability::Flying.new, Magic::Ability::GetPowerToughness.new(1,0)],
      toughness: 5,
      power: 5,
      expansion: 'Dominaria Remastered',
      rarity: Magic::Rarity::Rare,
      illustration: 'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=599009&type=card',
      flavor_text: 'The undisputed master of the mountains of Shiv.',
      artist: 'Donato Giancola',
      collector_number: 135,
    )
  end
end
