# Copyright (c) 2011-12 Michael Dvorkin
#
# Quickie is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.dirname(__FILE__) + "/lib/quickie_motion/version"

Gem::Specification.new do |s|
  s.name        = "quickie_motion"
  s.version     = Quickie.version
  s.authors     = "Michael Dvorkin"
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.email       = "mike@dvorkin.net"
  s.homepage    = "http://github.com/michaeldv/quickie_motion"
  s.summary     = "Micro framework for in-place testing of RubyMotion code"
  s.description = "Quickie adds Object#should, Object#should_not, and Object#stub methods for quick and easy testing of your RubyMotion code"

  s.files         = Dir["[A-Z]*[^~|lock]"] + Dir["lib/**/*.rb"] + [".gitignore"]
  s.test_files    = Dir["test/*"]
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
end
