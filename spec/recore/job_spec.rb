require 'spec_helper'

describe "REcore::Job" do
  it "should add jobs" do
    $stdout.should_receive(:puts).with("foo")
    $stdout.should_not_receive(:puts).with("bar")

    Outputer = Proc.new {|data| $stdout.puts data }

    REcore::start do
      job1 = REcore::Job.new "foo", &Outputer
      job2 = REcore::Job.new "bar", &Outputer
      quit_job = REcore::Job.new(nil) do
	REcore::quit!
      end

      job2.destroy.should eq "bar"
    end
  end
end
