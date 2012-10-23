class AppDelegate

  ActiveRecord = mock

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    quckie do
      run_matcher_tests
      run_stub_tests
      run_mock_tests
    end
    true
  end

  # Toggle ENV["quickie_motion_test"] to force Quickie return true/false instead
  # of printing "." or "F". This way we can get hold of test outcomes without
  # capturing $stdout (since StringIO is not supported by RubyMotion).
  #------------------------------------------------------------------------------
  def capture
    stats = Quickie::Runner.instance_variable_get(:@stats)
    trace = Quickie::Runner.instance_variable_get(:@trace)

    ENV["quickie_motion_test"] = "true"
    passed = yield
  ensure
    if passed
      stats[:success] -= 1
    else
      stats[:failure] -= 1
      trace.pop
    end
    ENV.delete("quickie_motion_test")
  end

  # Matcher tests.
  #------------------------------------------------------------------------------
  def run_matcher_tests

    # Should - passing tests.
    #--------------------------------------------------------------------------
    capture { "abc".should == "abc" }.should == true
    capture { "abc".should != "xyz" }.should == true
    capture { "abc".should =~ /AB/i }.should == true
    capture { "abc".should !~ /XY/i }.should == true
    capture { 1234567.should_be > 0 }.should == true

    # Should Not - passing tests.
    #--------------------------------------------------------------------------
    capture { "abc".should_not != "abc" }.should == true
    capture { "abc".should_not == "xyz" }.should == true
    capture { "abc".should_not !~ /AB/i }.should == true
    capture { "abc".should_not =~ /XY/i }.should == true
    capture { 1234567.should_not_be < 0 }.should == true

    # Should - failing tests.
    #--------------------------------------------------------------------------
    capture { "abc".should != "abc" }.should == false
    capture { "abc".should == "xyz" }.should == false
    capture { "abc".should !~ /AB/i }.should == false
    capture { "abc".should =~ /XY/i }.should == false
    capture { 1234567.should_be < 0 }.should == false

    # Should Not - failing tests.
    #--------------------------------------------------------------------------
    capture { "abc".should_not == "abc" }.should == false
    capture { "abc".should_not != "xyz" }.should == false
    capture { "abc".should_not =~ /AB/i }.should == false
    capture { "abc".should_not !~ /XY/i }.should == false
    capture { 1234567.should_not_be > 0 }.should == false

    # Stub tests.
    #--------------------------------------------------------------------------
    def run_stub_tests
      numbers = [ 1, 2, 3 ]
      letters = %w(a b c)

      numbers.stub! :join, :return => 42              # Stub numbers#join to return arbitrary value.
      numbers.join.should == 42                       # Test numbers.join().
      numbers.join(",").should == 42                  # Test numbers.join(arg).
      letters.join.should == "abc"                    # letters array is unaffected by numbers#join.

      letters.stub! :join, :return => "Hello, world!" # Now stub letters#join.
      letters.join.should == "Hello, world!"          # Test letters.join().
      letters.join(",").should == "Hello, world!"     # Test letters.join(arg).
      numbers.join.should == 42                       # numbers#join stub is unaffected by letters#join stub.
      numbers.join(",").should == 42                  # Ditto.

      numbers.stub :join, :remove                     # Remove numbers#join stub.
      numbers.join.should == "123"                    # numbers.join() should work as expected.
      numbers.join(",").should == "1,2,3"             # numbers.join(arg) should work as expected.
      letters.join.should == "Hello, world!"          # letters#join remains stubbed.

      letters.stub :join, :remove                     # Now remove letters#join stub.
      letters.join.should == "abc"                    # letters.join() should work as expected.
      letters.join(",").should == "a,b,c"             # letters.join(arg) should work as expected.
    end

    # Mock tests.
    #--------------------------------------------------------------------------
    def run_mock_tests
      record = { id: 42, name: "Quickie" }

      ActiveRecord.respond_to?(:find).should == false
      ActiveRecord.stub :find, :return => record
      ActiveRecord.respond_to?(:find).should == true
      ActiveRecord.find(42).should == record

      ActiveRecord.stub :where, :return => mock
      ActiveRecord.where.stub :sort, :return => mock
      ActiveRecord.where.sort.stub :limit, :return => record
      ActiveRecord.where(:name => "Quickie").sort("id DESC").limit(1).should == record

      ActiveRecord.to_s.should =~ /^#<Quickie::Mock:0x[a-f,0-9]+>/
    end
  end
end
