require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout link" do
    get root_url
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path

    # 检查contact页title
    get contact_path
    assert_select "title", full_title("Contact")

  end
end
