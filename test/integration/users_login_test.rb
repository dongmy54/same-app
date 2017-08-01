require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:dmy)
  end
  
  test "get login path should success" do
    get login_path
    assert_response :success    
  end

  test "login with invalid information" do
    get login_path
    post login_path, params: { session: { email: "",
                                          password: "" }}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "password" }}
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]" , login_path, count: 0
    assert_select "a[href=?]" , user_path(@user)
    assert_select "a[href=?]" , logout_path
    assert is_logged_in?
  end

  test "user logout" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "password" }}
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    # 模拟退出登录状态后，点击退出
    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "user with remembering" do
    log_in_as(@user, remember_me: "1")
    assert_not_empty cookies['user_id']
    assert_not_empty cookies['remember_token']
    assert_equal cookies['remember_token'], assigns(:user).remember_token
                                             # assigns让实例变量引入测试中，这里取用sessions 的controller中create中的@user
  end

  test "user without remembering" do
    log_in_as(@user, remember_me: "1")       # 说明测试前后的前后有影响，需要先清空此前cookies,再测试
    logout_path                              # 一定要在登录状态下，执行logout_path,不然不会执行forget(user)
    log_in_as(@user, remember_me: "0")
    assert_empty cookies['user_id']
    assert_empty cookies['remember_token']
  end


end
