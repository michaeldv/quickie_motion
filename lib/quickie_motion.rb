# Copyright (c) 2011-12 Michael Dvorkin
#
# Quickie is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  dir = File.dirname(__FILE__)
  app.files.unshift("#{dir}/quickie_motion/core_ext/kernel.rb")
  app.files.unshift("#{dir}/quickie_motion/core_ext/object.rb")
  app.files.unshift("#{dir}/quickie_motion/runner.rb")
  app.files.unshift("#{dir}/quickie_motion/matcher.rb")
  app.files.unshift("#{dir}/quickie_motion/stub.rb")
  app.files.unshift("#{dir}/quickie_motion/version.rb")
end
