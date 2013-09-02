module REcore
  module Callbacks
    module SimpleDataMixin
      private
      def load_object_from_pointer(pointer)
	pointer.null? ? nil : Marshal.load(pointer.read_string)
      end

      def serialized_object_pointer(object)
	return nil if object.nil?
        serialized_data = Marshal.dump(object)
	FFI::MemoryPointer.from_string(serialized_data)
      end

      def simple_data_callback(block)
        Proc.new do |pointer|
          block.call load_object_from_pointer(pointer)
	  1
	end
      end
    end
  end
end
