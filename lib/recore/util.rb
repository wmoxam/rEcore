module REcore
  module Util
    class << self
      def load_object_from_pointer(pointer)
	pointer.null? ? nil : Marshal.load(pointer.read_string)
      end

      def serialized_object_pointer(object)
	return nil if object.nil?
	serialized_data = Marshal.dump(object)
	FFI::MemoryPointer.from_string(serialized_data)
      end

      def string_pointers_from_array(array_of_strings)
	strptrs = array_of_strings.collect do |string|
	 FFI::MemoryPointer.from_string(string)
        end
	strptrs << nil

        # Now load all the pointers into a native memory block
	array = FFI::MemoryPointer.new(:pointer, strptrs.length)
	  strptrs.each_with_index do |p, i|
	  array[i].put_pointer(0,  p)
	end
        array
      end

      def string_array_from_pointer(pointer)
        elements = []
	loc = pointer
	until ((element = loc.read_pointer).null?)
	  elements << element.read_string
	  loc += FFI::Type::POINTER.size
	end
       
	elements
      end
    end
  end
end
