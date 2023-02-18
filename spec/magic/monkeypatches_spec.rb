RSpec.describe 'monkeypatches' do
  context String do
    it '#pascalcase' do
      expect(''.pascalcase).to eq ''
      expect('uno'.pascalcase).to eq 'Uno'
      expect('uno_dos_tres'.pascalcase).to eq 'UnoDosTres'
    end
  end

  context Symbol do
    it '#pascalcase' do
      expect(:uno.pascalcase).to eq 'Uno'
      expect(:uno_dos_tres.pascalcase).to eq 'UnoDosTres'
    end
  end
end
