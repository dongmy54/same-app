class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :user_valid,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user && @user.activated
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "请检查您的邮箱，点击重置密码链接（此链接两小时有效）。"
      redirect_to root_url
    else
      flash.now[:danger] = "你输入的邮箱无效，或该邮箱账户还未激活"
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "密码不能为空")
      render :edit
    elsif @user.update(user_params)
      log_in @user
      @user.update(:reset_digest => nil)
      flash[:success] = "密码修改成功"
      redirect_to @user
    else
      flash[:danger] = "重置密码失败"
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email]) 
    end

    def user_valid
      unless (@user && @user.activated? && 
              @user.authenticate?(:reset, params[:id]))
        flash[:danger] = "身份验证失败"
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "重置码已过期,请重新填写邮箱信息。"
        redirect_to new_password_reset_path
      end
    end

end
