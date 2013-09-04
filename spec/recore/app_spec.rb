require 'spec_helper'

describe "REcore::App" do
  it "should adjust args" do
    REcore::init
    REcore::App.args = %w(foo bar baz)
    REcore::App.args.should eq(%w(foo bar baz))
    REcore::shutdown
  end
end
