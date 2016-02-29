class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.password_match(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Logged in as #{@user.email}"
        redirect_to root_path
      else
        flash.now[:error] = "Something went wrong. Please try again."
        render :new
      end
    else
      flash.now[:error] = "Something went wrong. Please try again."
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    flash.notice = "Profile Updated!"
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :confirm_password)
  end
end
