Setup:
======

1. Symlink the selenium checkout to ./selenium-trunk
2. Run `gem install bundler && bundle install`
3. Use `vagrant-go.rb` to execute crazyfun targets.

This will be pretty slow for the time being since we set up the full VM from scratch on every command.

TODO 
====

-	use vagrant-snap to do snapshots/rollback.#!/usr/bin/env ruby

require 'rubygems'
require 'vagrant'
require 'logger'


target = ARGV.first or exit 1


ENV['VAGRANT_LOG'] = "STDOUT"
env = Vagrant::Environment.new
env.cli "up"


begin
  env.primary_vm.ssh.execute do |ssh|
    handler = lambda do |ch, type, data|
      case type
      when :stdout
        STDOUT.print data
      when :stderr
        STDERR.print data
      when :exit_status
        if data != 0
          command_failed(data)
        end
      end
    end
  
    ssh.exec!("DISPLAY=:1 PATH=/tmp/firefox/:$PATH cd /selenium-trunk && ./go #{target}", &handler)
  end
ensure
  # todo: snapshots.
  puts "destroying VM..."
  env.cli "destroy"
end