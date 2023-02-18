module Magic::Game::Eventable
  def apply(event)
  end

  def listen_for(event_class, recurrency_type = :always)
    Magic::Game::Event::Register.add_listener event_class, self, recurrency_type
  end
end
