class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('created_at').page(params[:page])
    redirect_to root_url
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
