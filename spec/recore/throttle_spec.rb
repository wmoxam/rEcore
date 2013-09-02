require 'spec_helper'

describe "REcore" do
  it "should adjust throttle" do
    REcore::init
    REcore::throttle = 0.7
    REcore::throttle.should eq(0.7)
    REcore::shutdown
  end
end
