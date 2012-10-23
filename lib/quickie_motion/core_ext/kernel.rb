# Copyright (c) 2011-2012 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module Kernel
  def quckie
    current, Exception.log_exceptions = Exception.log_exceptions, false
    yield
    Quickie::Runner.summary
  ensure
    Exception.log_exceptions = current
  end
  
  module_function :quckie
end