module REcore
  class << self
    def throttle
      Ecore::ecore_throttle_get
    end

    def throttle=(val)
      Ecore::ecore_throttle_adjust(0.7)
    end
  end
end
