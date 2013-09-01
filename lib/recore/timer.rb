module REcore
  class Timer
    def initialize(seconds, &block)
      @timer = Ecore::ecore_timer_add(seconds, block, nil)
    end
  end
end
