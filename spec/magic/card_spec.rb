RSpec.describe Magic::Card do
  let(:card) do
    described_class.new(
      name: 'Shivan Dragon',
      supertype: 'Creature',
      subtype: 'Dragon',
      mana_cost: Magic::ManaCost.from('4C2R'),
      abilities: [
        Magic::Ability::Passive::Flying,
        Magic::Ability::Active::GetPowerToughness.new(1, 0),
      ],
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

  before :each do
    card.listen_for Magic::Game::Event::StartBeginningPhase
    card.listen_for Magic::Game::Event::StartBeginningPhase
  end

  it 'build a card' do
    [
      :name,
      :supertype,
      :subtype,
      :mana_cost,
      :abilities,
      :toughness,
      :power,
      :expansion,
      :rarity,
      :illustration,
      :flavor_text,
      :artist,
      :collector_number,
    ].each { |prop| expect(card).to respond_to prop }
  end

  context 'with game context' do
    before :each do
      lib1 = Magic::Library.new cards: []
      lib2 = Magic::Library.new cards: []
      owner = Magic::Player.new library: lib1
      enemy = Magic::Player.new library: lib2
      turn = Magic::Game::Turn.new owner, enemy

      card.set_game_context(
        owner:,
        enemy:,
        turn:
      )
    end

    it 'can access game objects' do
      expect(card.context.owner).not_to be_nil
      expect(card.context.enemy).not_to be_nil
      expect(card.context.battlefield).not_to be_nil
      expect(card.context.graveyard).not_to be_nil
      expect(card.context.library).not_to be_nil
      expect(card.context.hand).not_to be_nil
      expect(card.context.turn).not_to be_nil
    end

    it 'can be tapped and untapped' do
      expect(card).not_to be_tapped
      expect { card.tap! }.to raise_error 'Not enough mana'

      card.context.owner.mana_pool.produce(colorless: 4, red: 2)
      card.tap!
      expect(card).to be_tapped

      expect { card.tap! }.to raise_error 'Already tapped'

      card.untap!
      expect(card).not_to be_tapped
    end

    it 'receives game events' do
      expect(card).to receive :apply

      card.context.turn.start!
    end
  end
end
