require 'gem_box'

GemBox.load { 'ecore-ffi' }

require_relative 'recore/util'
require_relative 'recore/callbacks'

require 'pry-nav'

module REcore
  class << self
    def init
      Ecore::ecore_init
    end

    def begin!
      Ecore::ecore_main_loop_begin
    end

    def quit!
      Ecore::ecore_main_loop_quit
    end

    def shutdown
      Ecore::ecore_shutdown
    end

    def start(args = [])
      init
      REcore::App.args = args

      yield

      begin!
      shutdown
    end
  end
end

require_relative 'recore/animator'
require_relative 'recore/app'
require_relative 'recore/event'
require_relative 'recore/job'
require_relative 'recore/throttle'
require_relative 'recore/time'
require_relative 'recore/timer'
require_relative 'recore/version'
