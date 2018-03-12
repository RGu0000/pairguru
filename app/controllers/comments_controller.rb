class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_already_commented!
  before_action :set_movie, only: %i[create destroy]

  def create
    movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    flash[:success] = "You have commented on #{movie.name}. Thank you."
    redirect_to movie
  end

  def destroy
  end

  private

  def set_list
    @movie = Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :message)
  end

  def check_if_already_rated!
    movie = Movie.find(params[:movie_id])
    redirect_to movie unless movie.comments.where(author_id: current_user.id).empty?
  end
end
