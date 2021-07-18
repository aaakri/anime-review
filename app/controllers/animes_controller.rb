class AnimesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find(params[:id])
    @review = current_user.reviews.build(anime: @anime)
    @reviews = Review.where(anime_id: params[:id])
  end

  def new
    @anime = Anime.new
  end

  def create
    @anime = current_user.animes.build(anime_params)
    
    if @anime.save
      flash[:success] = "アニメのタイトルが正常に登録されました"
      redirect_to @anime
    else 
      flash.now[:danger] = "アニメのタイトルが登録されませんでした"
      render :new
    end
  end

  def edit
     @anime = Anime.find(params[:id])
  end

  def update
    if @anime.update(anime_params)
      flash[:success] = "アニメタイトルは正常に更新されました"
      redirect_to @anime
    else
      flash.now[:danger] = "アニメタイトルは更新されませんでした"
      render :edit
    end
  end

  def destroy
    @anime.destroy
    flash[:success] = "アニメのタイトルは正常に消去されました"
    redirect_to root_url
  end
  
  private
  
  def anime_params 
    params.require(:anime).permit(:title)
  end
  
  
  def correct_user
    @anime = current_user.animes.find_by(id: params[:id])
    unless @anime
      redirect_to root_url
    end
  end
end
