# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../coverage_helper', __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module ActiveSupport
  # Test case
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
