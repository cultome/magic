RSpec.describe Magic::ManaCost do
  it 'parse a mana cost expression' do
    cost = Magic::ManaCost.from '1C2R3B4W5K6G'

    expect(cost.colorless).to eq 1
    expect(cost.red).to eq 2
    expect(cost.blue).to eq 3
    expect(cost.white).to eq 4
    expect(cost.black).to eq 5
    expect(cost.green).to eq 6
  end
end
