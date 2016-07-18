require 'test_helper'

class NewsFlowTest < ActionDispatch::IntegrationTest
  test 'can see the welcome page' do
    get '/'
    assert_select 'h1', 'Hello World'
  end
end
