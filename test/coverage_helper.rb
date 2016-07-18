require 'simplecov'

formatters = [SimpleCov::Formatter::HTMLFormatter]

# Code Climate code coverage
if ENV.key? 'CODECLIMATE_REPO_TOKEN'
  require 'codeclimate-test-reporter'
  formatters.push(CodeClimate::TestReporter::Formatter)
end

# Codecov
if ENV.key? 'CODECOV_TOKEN'
  require 'codecov'
  formatters.push(SimpleCov::Formatter::Codecov)
end

SimpleCov.formatters = formatters
SimpleCov.start do
  add_filter 'test'
end
