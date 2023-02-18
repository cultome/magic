class Magic::Game::Turn
  attr_reader :players, :current_player_idx, :current_moment_idx

  def initialize(player_1, player_2)
    @players = [player_1, player_2]
  end

  def next!(next_step_id = nil)
    valid_next_steps = next?
    if valid_next_steps.size == 1
      next_step = valid_next_steps.first[:id]

      # next player
      @current_player_idx = (current_player_idx + 1) % players.size if next_step < @current_moment_idx

      @current_moment_idx = next_step
    else
      raise 'You need to choose next step to take' if next_step_id.nil?
      raise 'Invalid next step' unless valid_next_steps.map { |step| step[:id] }.include?(next_step_id)

      # next player
      @current_player_idx = (current_player_idx + 1) % players.size if next_step_id < @current_moment_idx

      @current_moment_idx = next_step_id
    end
  end

  def next?
    turn_routes[current_moment_idx].map { |id| turn_moments[id] }
  end

  def started?
    !@current_player_idx.nil? && !@current_moment_idx.nil?
  end

  def start!
    @current_player_idx = 0
    @current_moment_idx = 1
  end

  def current_player
    must_be_started!
    players[current_player_idx]
  end

  def current_phase
    must_be_started!
    turn_moments[current_moment_idx][:phase]
  end

  def current_step
    must_be_started!
    turn_moments[current_moment_idx][:step]
  end

  private

  def turn_routes
    {
      1 => [2],
      2 => [3],
      3 => [4],
      4 => [5, 10],
      5 => [6],
      6 => [7],
      7 => [8],
      8 => [9],
      9 => [10],
      10 => [11],
      11 => [1],
    }
  end

  def turn_moments
    @turn_moments ||= {
      1 => { id: 1, phase: :beginning, step: :untap },
      2 => { id: 2, phase: :beginning, step: :upkeep },
      3 => { id: 3, phase: :beginning, step: :draw },
      4 => { id: 4, phase: :main, step: :first },
      5 => { id: 5, phase: :combat, step: :declare_attackers },
      6 => { id: 6, phase: :combat, step: :declare_blockers },
      7 => { id: 7, phase: :combat, step: :combat_damage },
      8 => { id: 8, phase: :combat, step: :end_of_combat },
      9 => { id: 9, phase: :main, step: :second },
      10 => { id: 10, phase: :ending, step: :end },
      11 => { id: 11, phase: :ending, step: :cleanup },
    }
  end

  def must_be_started!
    raise 'Turn not started' unless started?
  end
end
