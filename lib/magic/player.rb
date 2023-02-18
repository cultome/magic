class Magic::Player
  attr_reader :lives, :mana_pool

  def initialize
    @lives = 20
    @mana_pool = Magic::ManaPool.new
  end
end
