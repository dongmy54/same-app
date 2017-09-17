class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user

    mail to: @user.email, subject: "激活您的账户（自：sample app)"
  end

  def password_reset(user)
    @user = user

    mail to: @user.email, subject: "重置您的密码 （自：sample app)"
  end
end
