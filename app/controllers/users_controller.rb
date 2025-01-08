class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome! You have signed up successfully."
    else
      flash.now[:alert] = "There was an error with your registration. Please try again."
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end