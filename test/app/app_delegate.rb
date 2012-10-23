class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    quckie do
      1.should == 1
      2.should == 2
      3.should == 0
    end

    true
  end
end
