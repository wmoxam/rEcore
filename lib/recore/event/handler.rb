module REcore
  module Event
    class Handler
      def initialize(type, &block)
	@type = type
	@callback = block
        @handler = Ecore::ecore_event_handler_add(type_id_from_symbol(type), callback, nil)
      end

      private
      # TODO: we'll probably want to delegate to a Signal class
      def callback
        Proc.new do |data, type, ev|
          event = Ecore::EcoreEventSignalExit.new(ev)
	  event_type = [:interrupt, :quit, :terminate].find {|sym| event[sym] }

	  @callback.call(event_type)
	  1
	end
      end

      def type_id_from_symbol(sym)
        case sym
	when :exit
	  Ecore::ECORE_EVENT_SIGNAL_EXIT
	end
      end
    end
  end
end
