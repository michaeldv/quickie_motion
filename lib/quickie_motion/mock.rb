# Copyright (c) 2011-12 Michael Dvorkin
#
# Quickie is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module Quickie
  class Mock
    alias :__methods     :methods
    alias :__respond_to? :respond_to?

    begin
      current, Exception.log_exceptions = Exception.log_exceptions, false
      instance_methods.each do |method|
        unless method =~ /(?:__|:)/ || [ :==, :===, :!=, :ai, :class, :object_id, :respond_to_missing?, :to_s ].include?(method)
          undef_method method rescue nil # Suppress cannot undefine method `???' because it is a native method (RuntimeError)
        end
      end
    ensure
      Exception.log_exceptions = current
    end

    def initialize
      @stash = {}
    end

    def stub(method, options = {})
      unless __methods.include?(method)
        options[:return] ||= nil
        @stash[method] = options
      else
        super(method, options)
      end
      self
    end
    alias :stub! :stub

    def inspect
      self.to_s
    end

    def instance_variables
      []
    end

    def methods
      (__methods - [ :__methods, :__respond_to?, :instance_variables, :respond_to_missing? ] + @stash.keys).sort
    end

    def method_missing(method, *args)
      if @stash.key?(method) then
        @stash[method][:return]
      else
        raise NoMethodError, "undefined method `%s', expected one of %p" % [ method, methods ]
      end
    end

    def respond_to?(method)
      return true if @stash.key?(method.to_sym)
      __respond_to?(method)
    end
  end
end
