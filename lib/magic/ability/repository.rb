module Magic::Ability::Repository
  extend self

  def on_play(card)
    if CARD_FX.key? card.name
      CARD_FX[card.name].call card
    end
  end

  CARD_FX = {
    'Ach! Hans, Run!' => Proc.new do |card|
      card.listen_for Magic::Game::Event::StartUpkeepStep

      def card.apply(event)
        if event.is_a? Magic::Game::Event::StartUpkeepStep
          puts "\n111111111\n2222222222\n333333333\n44444444\n5555555555\n666666666666\n77777777777"
        end
      end
    end,
  }
end
