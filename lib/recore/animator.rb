module REcore
  class Animator
    include REcore::Callbacks::SimpleDataMixin

    def initialize(data = nil, runtime = nil, &block)
      @animator = if runtime.nil?
	Ecore::ecore_animator_add(simple_data_callback(block),
				  REcore::Util::serialized_object_pointer(data))
      else
        Ecore::ecore_animator_timeline_add(runtime,
					   timeline_callback(block),
                                           REcore::Util::serialized_object_pointer(data))
      end
    end

    def destroy
      REcore::Util::load_object_from_pointer Ecore::ecore_animator_del(@animator)
    end

    def self.custom_tick!
      Ecore::ecore_animator_custom_tick
    end

    def self.frametime
      Ecore::ecore_animator_frametime_get
    end

    def self.frametime=(val)
      Ecore::ecore_animator_frametime_set(val)
    end

    #
    # Mappings:
    # :linear - Linear, returns pos
    # :accelerate - Start slow then speed up
    # :decelerate - Start fast then slow down
    # :sinusoidal - Start slow, speed up then slow down at end
    # :accelerate_factor - Start slow then speed up, v1 being a power factor, 0.0 being linear, 1.0 being :accelerate, 2.0 being much more pronounced accelerate (squared), 3.0 being cubed, etc.
    # :decelerate_factor - Start fast then slow down, v1 being a power factor, 0.0 being linear, 1.0 being :decelerate, 2.0 being much more pronounced decelerate (squared), 3.0 being cubed, etc.
    # :sinusoidal_facotr - Start slow, speed up then slow down at end, v1 being a power factor, 0.0 being linear, 1.0 being :sinusoidal, 2.0 being much more pronounced sinusoidal (squared), 3.0 being cubed, etc.
    # :divisor_inter - Start at gradient * v1, interpolated via power of v2 curve
    # :bounce - Start at 0.0 then "drop" like a ball bouncing to the ground at 1.0, and bounce v2 times, with decay factor of v1
    # :spring - Start at 0.0 then "wobble" like a spring rest position 1.0, and wobble v2 times, with decay factor of v1
    def self.position_map(position, mapper, v1 = 0.0, v2 = 0.0)
      raise "Unkown mapping" unless Ecore::EcorePosMappings.include?(mapper)
      Ecore::ecore_animator_pos_map(position, mapper, v1, v2)
    end

    def self.source
      Ecore::ecore_animator_source_get
    end

    def self.source=(val)
      raise "Unknown source" unless Ecore::EcoreAnimatorSources.include?(val)
      Ecore::ecore_animator_source_set(val)
    end

    def self.custom_source_tick_begin(data = nil, &block)
      Ecore::ecore_animator_custom_source_tick_begin_callback_set(simple_data_callback(block),
								  REcore::Util::serialized_object_pointer(data))
    end

    def self.custom_source_tick_end(data = nil, &block)
	Ecore::ecore_animator_custom_source_tick_end_callback_set(simple_data_callback(block),
								  REcore::Util::serialized_object_pointer(data))
    end
    
    def freeze!
      Ecore::ecore_animator_freeze(@animator)
    end

    def thaw!
      Ecore::ecore_animator_thaw(@animator)
    end

    private
    def timeline_callback(block)
      Proc.new do |pointer, position|
        block.call REcore::Util::load_object_from_pointer(pointer), position
      end
    end
  end
end
