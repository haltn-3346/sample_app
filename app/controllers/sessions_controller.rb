class SessionsController < ApplicationController
  def new; end

  def create
<<<<<<< HEAD
    user = User.find_by(email: params[:session][:email].downcase)
=======
    user = User.find_by email: params[:session][:email].downcase
>>>>>>> 15988b96 (chapter 9)
    if user&.authenticate(params[:session][:password])
      handle_login user
    else
      flash.now[:danger] = t(".invalid")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
