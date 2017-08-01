module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticate?(cookies.signed[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?  
  end

  def logout
    forget current_user if logged_in?
    session.delete(:user_id)
    @current_user = nil  
  end

  def remember(user)
    user.remember
    cookies.signed.permanent[:remember_token] = user.remember_token
    cookies.signed.permanent[:user_id] = user.id
  end

  def forget(user)
    user.forget
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end

end
