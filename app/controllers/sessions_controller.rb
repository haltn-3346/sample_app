class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      handle_login user
    else
      flash[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def handle_login user
    if user.activated?
      log_in user
      if params[:session][:remember_me] == Settings.true
        remember(user)
      else
        forget(user)
      end
      redirect_back_or user
    else
      flash[:warning] = t ".act_warning"
      redirect_to root_url
    end
  end
end
