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

end
