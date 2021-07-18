class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:show, :animes, :reviews]

  def show
    @user = User.find(params[:id])
    @animes = @user.animes.order(id: :desc).page(params[:page])
    counts(@user)
    @users = User.order(id: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def animes
    @user = User.find(params[:id])
    @animes = @user.animes.page(params[:page])
    counts(@user)
  end
  
  def reviews
    @user = User.find(params[:id])
    @reviews = @user.reviews.eager_load(:anime).page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find_by(id: params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end
end
