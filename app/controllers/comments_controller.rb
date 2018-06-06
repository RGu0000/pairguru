class CommentsController < ApplicationController
  before_action :authenticate_user!, except: :top_commenters
  before_action :set_movie, only: %i[create destroy]

  def create
    @comment = @movie.comments.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      flash[:notice] = "You have commented on #{@movie.title}. Thank you."
    elsif @comment.message.empty?
      flash[:danger] = 'Failed to add new comment. It can\'t be empty!'
    else
      flash[:danger] = 'Failed to add new comment. Delete previous one first!'
    end
    redirect_to @movie
  end

  def destroy
    comment = @movie.comments.find(params[:id])
    if comment.author_id == current_user.id && comment.destroy
      flash[:notice] = 'Comment successfully deleted!'
    else
      flash[:danger] = 'Failed to delete a comment. Try again.'
    end
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
    params.require(:comment).permit(:message, :movie_id)
  end
end
