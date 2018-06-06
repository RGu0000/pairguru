class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[rate destroy]

  def rate
    @rating = Rating.new(rating_params)
    if @rating.save
      flash[:notice] = "You have rated #{@movie.title}. Thank you."
    else
      flash[:danger] = 'You have already rated this movie!'
    end
    redirect_to @movie
  end

  private

  def rating_params
    params.permit(:movie_id, :user_id, :score)
  end

  def set_movie
    @movie = Movie.find_by(id: params[:movie_id])
  end
end
