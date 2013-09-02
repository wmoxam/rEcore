module REcore
  class Job
    def initialize(data = nil, &block)
      serialized_data = data.nil? ? nil : Marshal.dump(data)
      @data_pointer = data.nil? ? nil : FFI::MemoryPointer.from_string(serialized_data)
      @callback_block = block
      @job = Ecore::ecore_job_add(callback, @data_pointer)
    end

    def destroy
      load_data Ecore::ecore_job_del(@job)
    end

    private
    def callback
      @cb ||= Proc.new do |data|
        begin
	  ruby_data = load_data(data)
	  @callback_block.call ruby_data
        rescue Exception => e
	  raise e.message + self.inspect
	end
	1
      end
    end

    def load_data(data)
      data.null? ? nil : Marshal.load(data.read_string)
    end
  end
end
