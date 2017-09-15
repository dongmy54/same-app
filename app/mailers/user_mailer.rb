class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user

    mail to: @user.email , subject: "激活您的账户（自：sample app)"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
