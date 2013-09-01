module REcore
  class Time
    def self.now
      Ecore::ecore_time_get
    end
  end
end
