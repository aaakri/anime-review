class ApplicationController < ActionController::Base

  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_animes = user.animes.count
    @count_reviews = user.reviews.count
  end
end