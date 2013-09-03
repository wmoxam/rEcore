module REcore
  module Callbacks
    module SimpleDataMixin
      private
      def simple_data_callback(block)
        Proc.new do |pointer|
          block.call REcore::Util::load_object_from_pointer(pointer)
	  1
	end
      end
    end
  end
end
