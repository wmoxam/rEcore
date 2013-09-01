require 'gem_box'

GemBox.load { 'ecore-ffi' }

require_relative 'recore/util'

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

    def set_app_args(args)
      return if args.nil? || args.empty?
      pointers = Util::string_pointers_from_array(args)
      Ecore::ecore_app_args_set(args, pointers)
    end

    def shutdown
      Ecore::ecore_shutdown
    end

    def start(args = [])
      init
      set_app_args(args)

      yield

      begin!
      shutdown
    end
  end
end

require_relative 'recore/event'
require_relative 'recore/time'
require_relative 'recore/timer'
require_relative 'recore/version'
