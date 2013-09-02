require 'spec_helper'

describe "REcore" do
  it "should initialize" do
    REcore::init.should eq(1)
    REcore::shutdown.should eq(0)
  end
end
