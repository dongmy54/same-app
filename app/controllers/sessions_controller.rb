class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:warning] = "邮箱或者密码无效！" 
      render 'new'
    end 
  end

  def destroy
    logout
    redirect_to root_path
  end

end
