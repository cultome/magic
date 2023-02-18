RSpec.describe Magic::ManaPool do
  let(:mana_pool) { described_class.new(colorless: 5, red: 2) }

  it 'checks a mana cost' do
    cost = Magic::ManaCost.from '1C2R'

    expect(mana_pool.has?(cost)).to eq true
  end

  it 'add mana to the pool' do
    mana_pool.add!(colorless: 1, red: 2, blue: 3)

    expect(mana_pool.colorless).to eq 6
    expect(mana_pool.red).to eq 4
    expect(mana_pool.blue).to eq 3
    expect(mana_pool.white).to eq 0
    expect(mana_pool.black).to eq 0
    expect(mana_pool.green).to eq 0
  end
end
