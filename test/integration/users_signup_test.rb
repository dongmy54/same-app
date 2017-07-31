require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get new_user_path
    
    assert_no_difference "User.count" do
      post users_path, params: { user: {
                                        name: "",
                                        email: "hu@bar",
                                        password: "foobar",
                                        password_confirmation: "foobar" } }   
    end
    assert_template "users/new"
    assert_select 'div#error_explanation'
    assert_select 'div.alert' 
  end

  test "valid signup information" do
    get new_user_path

    assert_difference 'User.count', 1 do
      post signup_path, params: { user:{ name: "Example User",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    assert is_logged_in?
  end

end
