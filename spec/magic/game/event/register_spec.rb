RSpec.describe Magic::Game::Event::Register do
  let(:my_event_class) { Class.new }

  it 'remove listeners when recurrence is due' do
    card = double("card")

    described_class.add_listener my_event_class, card, 1

    expect(card).to receive(:apply).once

    described_class.process_event my_event_class.new
    described_class.process_event my_event_class.new
  end

  it 'on double registro of the same listener, only the recurrence type is updated' do
    card = double("card")

    expect{ described_class.recurrence_type_for(my_event_class, card)}.to raise_error 'event type or listener not registered'

    described_class.add_listener my_event_class, card, 1
    expect(described_class.recurrence_type_for(my_event_class, card)).to eq 1

    described_class.add_listener my_event_class, card, :always
    expect(described_class.recurrence_type_for(my_event_class, card)).to eq :always
  end
end
