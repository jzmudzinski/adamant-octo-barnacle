require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = Dir.glob('tests/**/*.rb')
end

task(default: :test)
