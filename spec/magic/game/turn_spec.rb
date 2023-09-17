RSpec.describe Magic::Game::Turn do
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
  let(:lib2) { Magic::Library.new cards: [] }
  let(:p1) { Magic::Player.new library: lib1 }
  let(:p2) { Magic::Player.new library: lib2 }
  let(:turn) { described_class.new(p1, p2) }

  it 'cannot double-start a turn' do
    turn.start!
    expect{ turn.start! }.to raise_error 'Turn already started'
  end

  it 'initialize a turn' do
    turn.start!
    expect(turn).to be_started

    expect(turn.current_player).to eq p1
    expect(turn.current_phase).to eq :beginning
    expect(turn.current_step).to eq :untap
  end

  it 'fails if not started' do
    expect(turn).not_to be_started

    expect{ turn.current_player }.to raise_error 'Turn not started'
    expect{ turn.current_phase }.to raise_error 'Turn not started'
    expect{ turn.current_step }.to raise_error 'Turn not started'
  end

  context 'walks the turn' do
    it 'with combat phase' do
      turn.start!

      expect(turn.current_phase).to eq :beginning
      expect(turn.current_step).to eq :untap
      expect(turn.next?).to eq [{ id: 2, phase: :beginning, step: :upkeep }]

      turn.next!
      expect(turn.next?).to eq [{ id: 3, phase: :beginning, step: :draw }]

      turn.next!
      expect(turn.next?).to eq [{ id: 4, phase: :main, step: :first_main }]

      turn.next!
      expect(turn.next?).to eq [{ id: 5, phase: :combat, step: :declare_attackers }, { id: 10, phase: :ending, step: :end }]
      expect{ turn.next! }.to raise_error 'You need to choose next step to take'
      expect{ turn.next!(6) }.to raise_error 'Invalid next step'

      turn.next!(5)
      expect(turn.next?).to eq [{ id: 6, phase: :combat, step: :declare_blockers }]

      turn.next!
      expect(turn.next?).to eq [{ id: 7, phase: :combat, step: :combat_damage }]

      turn.next!
      expect(turn.next?).to eq [{ id: 8, phase: :combat, step: :end_of_combat }]

      turn.next!
      expect(turn.next?).to eq [{ id: 9, phase: :main, step: :second_main }]

      turn.next!
      expect(turn.next?).to eq [{ id: 10, phase: :ending, step: :end }]

      turn.next!
      expect(turn.next?).to eq [{ id: 11, phase: :ending, step: :cleanup }]

      turn.next!
      expect(turn.next?).to eq [{ id: 1, phase: :beginning, step: :untap }]

      # switch current player after the last step
      before = turn.current_player
      turn.next!
      after = turn.current_player

      expect(before).not_to eq after

      # turn start over again
      expect(turn.current_phase).to eq :beginning
      expect(turn.current_step).to eq :untap
    end

    it 'without combat phase' do
      turn.start!
      expect(turn.next?).to eq [{ id: 2, phase: :beginning, step: :upkeep }]

      turn.next!
      expect(turn.next?).to eq [{ id: 3, phase: :beginning, step: :draw }]

      turn.next!
      expect(turn.next?).to eq [{ id: 4, phase: :main, step: :first_main }]

      turn.next!
      expect(turn.next?).to eq [{ id: 5, phase: :combat, step: :declare_attackers }, { id: 10, phase: :ending, step: :end }]

      turn.next!(10)
      expect(turn.next?).to eq [{ id: 11, phase: :ending, step: :cleanup }]
    end
  end

  context 'handles turn interruptions' do
    it 'when cards in hand/battlefield mention it' do
      # setup environment
      p1.mana_pool.produce(colorless: 2, red: 2, green: 2)
      p1.draw
      p1.play card

      expect(card).to receive(:apply).once

      turn.start!
      turn.next!
    end
  end
end
