class CommentsController < ApplicationController
  before_action :authenticate_user!
  #before_action :check_if_already_commented!
  before_action :set_movie, only: %i[create destroy]

  def create
    @comment = @movie.comments.build(comment_params)
    @comment.author_id = current_user.id
    @comment.movie_id = @movie.id
    if @comment.save
      flash[:notice] = "You have commented #{@movie.title}. Thank you."
    else
      flash[:danger] = "Failed to add new comment. Delete previous one first!"
    end
    redirect_to @movie
  end

  def destroy
  end

  private

  def set_movie
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
