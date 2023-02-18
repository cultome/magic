module Magic::Game::Event::Register
  @@listeners ||= Hash.new { |h, k| h[k] = [] }

  extend self

  def recurrence_type_for(event_class, listener)
    config = @@listeners[event_class].find { |lst| lst[:object] == listener }

    raise 'event type or listener not registered' if config.nil?

    config[:recurrence]
  end

  def add_listener(event_class, listener, recurrency_type)
    if @@listeners[event_class].any? { |lst| lst[:object] == listener }
      config = @@listeners[event_class].find { |lst| lst[:object] == listener }

      if config[:recurrence] != recurrency_type
        config[:recurrence] = recurrency_type
      end
    else
      @@listeners[event_class] << { object: listener, recurrence: recurrency_type }
    end
  end

  def process_event(event)
    return if @@listeners[event.class].empty?

    listeners = @@listeners[event.class]

    listeners.each do |listener|
      listener[:object].apply event

      if listener[:recurrence].is_a? Numeric
        listener[:recurrence] -= 1

        if listener[:recurrence] <= 0
          @@listeners[event.class].delete listener
        end
      end
    end
  end
end
