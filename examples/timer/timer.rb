#!/usr/bin/ruby

$LOAD_PATH.unshift(File.dirname(__FILE__) + "/../..")
require 'lib/recore'


REcore::start(ARGV) do
  start_time = REcore::Time.now

  handler = REcore::Event::Handler.new(:exit) do |event_type|
    puts "Exit: #{event_type}"
    REcore::quit!
  end

  timer = REcore::Timer.new(0.5) do
    puts "Tick timer. Sec: #{'%3.2f' % (REcore::Time.now - start_time)}"
  end
end
