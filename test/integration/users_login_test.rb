require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:dmy)
  end
  
  test "get login path should success" do
    get login_path
    assert_response :success    
  end

  test "invalid email/password should have error message" do
    get login_path
    post login_path, params: { session: { email: "",
                                          password: "" }}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "valid email/pasword should login" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "password" }}
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]" , login_path, count: 0
    assert_select "a[href=?]" , user_path(@user)
    assert_select "a[href=?]" , logout_path
    assert is_logged_in?
  end


end
