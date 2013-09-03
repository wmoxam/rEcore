require 'spec_helper'

describe "REcore::Animator" do
  before(:each) do
    REcore.init
  end

  after(:each) do
    REcore::shutdown
  end

  it "creates and deletes animators" do
    animator = REcore::Animator.new("foo") {|s| puts s }
    animator.destroy.should == "foo"
  end

  it "creates and deletes timeline animators" do
    animator = REcore::Animator.new("foo", 5) {|s| puts s }
    animator.destroy.should == "foo"
  end

  it "sets global frametime" do
    REcore::Animator.frametime = 22
    REcore::Animator.frametime.should == 22
  end

  it "performs position map calculations" do
    REcore::Animator.position_map(0.7, :linear).should == 0.7
  end

  it "sets global source" do
    REcore::Animator.source.should == :timer
    REcore::Animator.source = :custom
    REcore::Animator.source.should == :custom
  end

  it "sets source tick callbacks" do
    $stdout.should_receive(:puts).with("begin")
    $stdout.should_receive(:puts).with("end")

    REcore::Animator.custom_source_tick_begin('begin') {|s| puts s }
    REcore::Animator.custom_source_tick_end('end') {|s| puts s }
  end

  it "should freeze and thaw" do
    animator = REcore::Animator.new("foo") {|s| puts s }
    animator.freeze!
    animator.thaw!
  end
end
