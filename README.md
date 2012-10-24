## Quickie for RubyMotion ##
Quickie for RubyMotion is a gem for quick in-place testing of your RubyMotion code. It provides
four useful methods:

* <code>Object#should</code> and <code>Object#should\_not</code> for positive and negative assertions.
* <code>Object#stub</code> for method stubbing.
* <code>Kernel#mock</code> for creating object mocks.

### Installation ###
    # Installing as Ruby gem
    $ gem install quickie_motion

    # Cloning the repository
    $ git clone git://github.com/michaeldv/quickie_motion.git

### Usage ###
Generate RubyMotion project, then require "quickie_motion" in projects's Rakefile:

    # -*- coding: utf-8 -*-
    $:.unshift("/Library/RubyMotion/lib")
    require "motion/project"
    require "quickie_motion"

    Motion::Project::App.setup do |app|
      app.name = "your_app_name"
    end

Add your Quickie tests to the AppDelegate as follows:

    class AppDelegate
      def application(application, didFinishLaunchingWithOptions:launchOptions)
        #
        # Your application code.
        #
        return true if RUBYMOTION_ENV == "release"
        #
        # Your tests.
        #
        quickie do
          run_tests
          run_more_tests
        end 
      end

      private

      def run_tests
        1.should == 1
      end

      def run_more_tests
        true.should_not == false
      end
    end

For more information about the usage of assertions and stubs please check http://github.com/michaeldv/quickie.

### Testing Quickie for RubyMotion ###
Quickie code is tested by the Quickie itself.

    $ rake quickie
         Build ./build/iPhoneSimulator-6.0-Development
      Simulate ./build/iPhoneSimulator-6.0-Development/quickie_motion_test.app
    .....................................

    Passed: 37, not quite: 0, total tests: 37.
    (main)>

For more details please check <code>quickie_motion_test</code> application in the <code>test</code> directory.

### Note on Patches/Pull Requests ###
* Fork the project on Github.
* Make your feature addition or bug fix.
* Add tests for it making sure $ rake quickie passes 100%.
* Commit, do not mess with Rakefile, version, or history.
* Send me commit URL (*do not* send pull requests).

### License ###
Copyright (c) 2010-2012 Michael Dvorkin

http://www.dvorkin.net

%w(mike dvorkin.net) * "@" || %w(mike fatfreecrm.com) * "@"

Released under the MIT license. See LICENSE file for details.
