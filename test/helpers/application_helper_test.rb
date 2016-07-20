class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  test 'should render markdown' do
    html = markdown ['- one', '- two', '- three'].join("\n")
    assert_equal html, [
      '<ul>',
      '<li>one</li>',
      '<li>two</li>',
      '<li>three</li>',
      '</ul>'
    ].join("\n") + "\n"
  end

  test 'should not render HTML in markdown' do
    assert_equal markdown('<a>link</a>'), "<p>&lt;a&gt;link&lt;/a&gt;</p>\n"
    assert_equal markdown('<img>'), "<p>&lt;img&gt;</p>\n"
    assert_equal markdown('<script>alert("nok")</script>'), "<p>&lt;script&gt;alert(&quot;nok&quot;)&lt;/script&gt;</p>\n"
  end
end
