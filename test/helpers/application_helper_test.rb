require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    title = "Ruby on Rails Tutorial Sample App"
    assert_equal full_title, title
    assert_equal full_title("Help"), "Help | #{title}"
  end
end