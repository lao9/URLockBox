class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    message = @user.check_user_errors(check_user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome!"
      redirect_to links_path
    else
      flash[:error] = message
      redirect_to new_user_path
    end
  end

  private

  def check_user_params
    user_params.merge!({pass_confirm: params[:user][:password_confirmation]})
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
