RSpec.describe Magic::Player do
  let(:card) do
    Magic::Card.new(
      name: 'Ach! Hans, Run!',
      supertype: 'Enchantment',
      mana_cost: Magic::ManaCost.from('2C2R2G'),
      expansion: 'Unhinged',
      rarity: Magic::Rarity::Rare,
      illustration: 'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=73935&type=card',
      card_text: "At the beginning of your upkeep, you may say \"Ach Hans, run It's the . . .\" and the name of a creature card. If you do, search your library for a card with that name, put it onto the battlefield, then shuffle. That creature gains haste. Exile it at the beginning of the next end step.",
      artist: 'Quinton Hoover',
      collector_number: 116,

    )
  end
  let(:lib1) { Magic::Library.new cards: [card] }
  let(:player) { described_class.new library: lib1 }

  it 'creates a player' do
    expect(player.lives).to eq 20
  end

  it 'has a mana pool' do
    expect(player.mana_pool).not_to be_nil
  end

  it 'draw cards from library and put them on hand' do
    expect(player.library).not_to be_empty
    expect(player.hand).to be_empty

    player.draw

    expect(player.library).to be_empty
    expect(player.hand).not_to be_empty
  end

  it 'plays a card' do
    player.draw

    expect(player.hand).not_to be_empty
    expect(player.battlefield).to be_empty

    player.mana_pool.produce(colorless: 2, red: 2, green: 2)
    player.play card

    expect(player.hand).to be_empty
    expect(player.battlefield).not_to be_empty
  end
end
