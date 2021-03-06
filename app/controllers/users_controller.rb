class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find_by_id(params[:id])

  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end
  def edit
    user_id = params[:id]
    @user = User.find_by_id(user_id)

    unless current_user == @user
      if current_user
        redirect_to user_path(current_user.id)
      else
        redirect_to login_path
      end
    end
  end
  def update
    user_id = params[:id]
    user = User.find_by_id(user_id)
    user.update_attributes(user_params)
    redirect_to user_path(user_id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :current_city, :join_date, :email, :password, :avatar)
  end
end
