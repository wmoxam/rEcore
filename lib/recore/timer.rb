module REcore
  class Timer
    def initialize(seconds, &block)
      @callback = block
      @timer = Ecore::ecore_timer_add(seconds, callback, nil)
    end

    private
    def callback
      Proc.new do
        @callback.call
        1
      end
    end
  end
end
