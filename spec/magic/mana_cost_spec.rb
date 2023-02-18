RSpec.describe Magic::ManaCost do
  it 'parse a mana cost expression' do
    cost = Magic::ManaCost.from '4C2W3R'

    expect(cost.white).to eq 2
    expect(cost.red).to eq 3
    expect(cost.colorless).to eq 4
  end
end
