
Rake.verbose(true)

desc 'Debug mode in RubyMine (Use :start for actual tests)'
task :debug do
  system('rackup')
end

desc 'Start the server'
task :start do
  system('bundle exec passenger start --min-instances 2  --sticky-sessions')
end