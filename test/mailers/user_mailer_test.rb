require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:dmy)
    mail = UserMailer.account_activation(user)
    assert_equal "激活您的账户（自：sample app)", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["sample@example.com"], mail.from
  end

  test "password_reset" do
    user = users(:dmy)
    mail = UserMailer.password_reset(user)
    assert_equal "重置您的密码 （自：sample app)", mail.subject 
    assert_equal [user.email], mail.to
    assert_equal ["sample@example.com"], mail.from 
    # assert_match user.reset_token, mail.body.encoded 
    # assert_match CGI.escape(user.email), mail.body.encoded
  end

end
