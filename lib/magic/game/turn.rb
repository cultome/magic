# Handles the players turns
class Magic::Game::Turn
  attr_reader :players, :current_player_idx, :current_moment_idx

  def initialize(player_1, player_2)
    @players = [player_1, player_2]
  end

  def next!(expected_next_step_id = nil)
    before_moment = current_moment
    true_next_step_id = next_moment_idx expected_next_step_id
    after_moment = turn_moments[true_next_step_id]

    if before_moment[:step] != after_moment[:step]
      end_evt_class = Object.const_get "Magic::Game::Event::End#{before_moment[:step].pascalcase}Step"
      Magic::Game::Event::Register.process_event end_evt_class.new
    end

    if before_moment[:phase] != after_moment[:phase]
      end_evt_class = Object.const_get "Magic::Game::Event::End#{before_moment[:phase].pascalcase}Phase"
      Magic::Game::Event::Register.process_event end_evt_class.new
    end

    move_to_next_moment true_next_step_id # TODO: this should be moved after EndxxxxPhase event is processed

    if before_moment[:phase] != after_moment[:phase]
      start_evt_class = Object.const_get "Magic::Game::Event::Start#{after_moment[:phase].pascalcase}Phase"
      Magic::Game::Event::Register.process_event start_evt_class.new
    end

    if before_moment[:step] != after_moment[:step]
      start_evt_class = Object.const_get "Magic::Game::Event::Start#{after_moment[:step].pascalcase}Step"
      Magic::Game::Event::Register.process_event start_evt_class.new
    end

    after_moment
  end

  def next?
    turn_routes[current_moment_idx].map { |id| turn_moments[id] }
  end

  def started?
    !@current_player_idx.nil? && !@current_moment_idx.nil?
  end

  def start!
    raise 'Turn already started' if started?

    # revert values to start a new turn, but in fact is the first
    @current_player_idx = 1
    @current_moment_idx = 11

    next!
  end

  def current_moment
    turn_moments[current_moment_idx]
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

  def move_to_next_moment(next_step_id)
    next_step = next_moment_idx next_step_id

    @current_player_idx = (current_player_idx + 1) % players.size if next_step < @current_moment_idx

    @current_moment_idx = next_step
  end

  def next_moment_idx(next_step_id)
    valid_next_steps = next?

    if valid_next_steps.size == 1
      valid_next_steps.first[:id]
    else
      raise 'You need to choose next step to take' if next_step_id.nil?
      raise 'Invalid next step' unless valid_next_steps.map { |step| step[:id] }.include?(next_step_id)

      next_step_id
    end
  end

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
      4 => { id: 4, phase: :main, step: :first_main },
      5 => { id: 5, phase: :combat, step: :declare_attackers },
      6 => { id: 6, phase: :combat, step: :declare_blockers },
      7 => { id: 7, phase: :combat, step: :combat_damage },
      8 => { id: 8, phase: :combat, step: :end_of_combat },
      9 => { id: 9, phase: :main, step: :second_main },
      10 => { id: 10, phase: :ending, step: :end },
      11 => { id: 11, phase: :ending, step: :cleanup },
    }
  end

  def must_be_started!
    raise 'Turn not started' unless started?
  end
end
