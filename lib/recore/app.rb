module REcore
  class App
    def self.args
      args_ptr = FFI::MemoryPointer.new :pointer
      Ecore::ecore_app_args_get(nil, args_ptr)
      Util::string_array_from_pointer(args_ptr.get_pointer(0))
    end

    def self.args=(array)
      return if array.nil? || array.empty?
      pointers = Util::string_pointers_from_array(array)
      Ecore::ecore_app_args_set(array.length, pointers)
    end

    def self.restart!
      Ecore::ecore_app_restart
    end
  end
end
