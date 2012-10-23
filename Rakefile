require "bundler"
Bundler::GemHelper.install_tasks

desc "Build quickie tests and run them"
task :quickie do
  system "cd ./test && rake && cd .."
end
