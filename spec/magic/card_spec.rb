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
      owner = Magic::Player.new
      enemy = Magic::Player.new
      battlefield = Magic::Battlefield.new
      graveyard = Magic::Graveyard.new
      library = Magic::Library.new
      hand = Magic::Hand.new

      card.set_game_context(owner:, enemy:, battlefield:, graveyard:, library:, hand:)
    end

    it 'can access game objects' do
      expect(card.context.owner).not_to be_nil
      expect(card.context.enemy).not_to be_nil
      expect(card.context.battlefield).not_to be_nil
      expect(card.context.graveyard).not_to be_nil
      expect(card.context.library).not_to be_nil
      expect(card.context.hand).not_to be_nil
    end

    it 'can be tapped and untapped' do
      expect(card).not_to be_tapped
      expect{ card.tap! }.to raise_error 'Not enough mana'

      card.context.owner.mana_pool.add!(colorless: 4, red: 2)
      card.tap!
      expect(card).to be_tapped

      expect{ card.tap! }.to raise_error 'Already tapped'

      card.untap!
      expect(card).not_to be_tapped
    end

    xit 'receives game events' do
    end
  end
end
