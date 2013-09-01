module REcore
  module Util
    class << self
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
    end
  end
end
