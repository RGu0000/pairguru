class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[create destroy]

  def create
    @comment = @movie.comments.new(comment_params)
    initialize_comment
    if @comment.save
      flash[:notice] = "You have commented on #{@movie.title}. Thank you."
    else
      flash[:danger] = 'Failed to add new comment. Delete previous one first!'
    end
    redirect_to @movie
  end

  def destroy
    @movie.comments.find(params[:id]).destroy
    flash[:notice] = 'Comment successfully deleted!'
    redirect_to @movie
  end

  def top_commenters
    @top_commenters = CommentsQuery.new.find_top_10_commenters
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:message)
  end

  def initialize_comment
    @comment.author_id = current_user.id
    @comment.movie_id = @movie.id
  end
end
