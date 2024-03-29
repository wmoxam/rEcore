module REcore
  class Job
    include REcore::Callbacks::SimpleDataMixin

    def initialize(data = nil, &block)
      @job = Ecore::ecore_job_add(simple_data_callback(block),
				  REcore::Util::serialized_object_pointer(data))
    end

    def destroy
      REcore::Util::load_object_from_pointer Ecore::ecore_job_del(@job)
    end
  end
end
