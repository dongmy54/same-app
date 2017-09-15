require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:dmy)
    mail = UserMailer.account_activation(user)
    assert_equal "激活您的账户（自：sample app)", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["sample@example.com"], mail.from
  end

  # test "password_reset" do
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
