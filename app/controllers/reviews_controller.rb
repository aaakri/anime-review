class ReviewsController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]
   
  def index
    @reviews = Review.all
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.anime_id = params[:anime_id]
    
    if @review.save
      flash[:success] = "レビューを投稿しました。"
      redirect_to anime_path(params[:anime_id])
    else
      @anime = Anime.find(params[:anime_id])
      @reviews = @anime.reviews
      flash.now[:danger] = "レビューの投稿に失敗しました。"
      render "animes/show"
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "レビューを削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:content)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
end
