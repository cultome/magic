RSpec.describe Magic::Player do
  let(:player) { described_class.new }

  it 'creates a player' do
    expect(player.lives).to eq 20
  end

  it 'has a mana pool' do
    expect(player.mana_pool).not_to be_nil
  end
end
