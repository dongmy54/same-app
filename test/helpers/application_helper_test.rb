require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Ruby On Rails"
    assert_equal full_title("title"), "title | Ruby On Rails"
  end

end
