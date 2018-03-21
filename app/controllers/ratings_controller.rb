class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[create destroy]

  def rate
    @rating = Rating.new
    initialize_rating
    if @rating.save
      flash[:notice] = "You have rated #{@movie.title}. Thank you."
    else
      flash[:danger] = 'You have already rated this movie!'
    end
    redirect_to @movie
  end

  def average_rating

  end

  private

  def initialize_rating
    @movie = Movie.find(params[:movie_id])
    @rating.movie_id = params[:movie_id]
    @rating.user_id = current_user.id
    @rating.rating = params[:rating]
  end

  def rating_params
    params.require(:rating).permit(:movie_id, :user_id, :rating)
  end

  def set_movie
    @movie = Movie.find_by(params[:movie_id])
  end
end
