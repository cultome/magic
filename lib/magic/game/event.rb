module Magic::Game::Event
  class StartBeginningPhase
  end

  class EndBeginningPhase
  end

  class StartUntapStep
  end

  class EndUntapStep
  end

  class StartUpkeepStep
  end

  class EndUpkeepStep
  end

  class StartDrawStep
  end

  class EndDrawStep
  end

  class StartMainPhase
  end

  class EndMainPhase
  end

  class StartFirstMainStep
  end

  class EndFirstMainStep
  end

  class StartSecondMainStep
  end

  class EndSecondMainStep
  end

  class StartCombatPhase
  end

  class EndCombatPhase
  end

  class StartDeclareAttackersStep
  end

  class EndDeclareAttackersStep
  end

  class StartDeclareBlockersStep
  end

  class EndDeclareBlockersStep
  end

  class StartCombatDamageStep
  end

  class EndCombatDamageStep
  end

  class StartEndOfCombatStep
  end

  class EndEndOfCombatStep
  end

  class StartEndingPhase
  end

  class EndEndingPhase
  end

  class StartEndStep
  end

  class EndEndStep
  end

  class StartCleanupStep
  end

  class EndCleanupStep
  end

  class CardRelatedEvent
    attr_reader :card

    def initialize(card)
      @card = card
    end
  end

  class HandCardAdded < CardRelatedEvent
  end

  class HandCardRemoved < CardRelatedEvent
  end

  class CardPlayed < CardRelatedEvent
  end
end

require_relative './event/register'
