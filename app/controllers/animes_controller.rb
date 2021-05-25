class AnimesController < ApplicationController
  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find(params[:id])
  end

  def new
    @anime = Anime.new
  end

  def create
    @anime = current_user.animes.build(anime_params)
    
    if @anime.save
      flash[:success] = "アニメのタイトルが正常に登録されました"
      redirect_to root_url
    else 
      flash.now[:danger] = "アニメのタイトルが登録されませんでした"
      render :root_url
    end
  end

  def edit
    
  end

  def update
  end

  def destroy
  end
end
