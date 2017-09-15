class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated && user.authenticate?(:activation, params[:id])
      user.activate
      flash[:success] = "您的账户已激活"
      log_in user
      redirect_to user
    else
      flash[:danger] = "激活失败"
      redirect_to root_url
    end  
  end

end
