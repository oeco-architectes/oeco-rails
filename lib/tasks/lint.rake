task test: :lint

task lint: :rubocop

task :rubocop do
  sh 'bin/bundle exec rubocop'
end
