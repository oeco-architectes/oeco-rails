require 'test_helper'

class NewsFlowTest < ActionDispatch::IntegrationTest
  fixtures :news

  test 'can see the home page' do
    get '/'
    assert_response :success
    assert_select 'h1', 'oeco architectes'

    assert_select 'ol' do
      assert_select 'li', 7
      [:one, :three, :two].each_with_index do |id, i|
        assert_select "li:nth-child(#{i + 1})" do
          assert_select 'h2', news(id).title
          assert_select 'p', news(id).summary
          assert_select 'img'
          assert_select 'img[src=?]', news(id).img_url(1024, 768).to_s
          assert_select 'img[alt=?]', news(id).title
        end
      end
    end
  end
end
