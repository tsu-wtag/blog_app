class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show] # Require login for all except show
  before_action :set_post
  before_action :set_comment, only: [:show, :destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment added successfully."
    else
      redirect_to @post, alert: "Failed to add comment."
    end
  end

  def show
  end

  def destroy
    puts "Current user ID: #{current_user&.id}"
    puts "Comment user ID: #{@comment.user_id}"
    puts "Post user ID: #{@post.user_id}"
    if @comment.user_id == current_user&.id || @post.user_id == current_user&.id
      @comment.destroy
      redirect_to @post, notice: "Comment deleted."
    else
      redirect_to @post, alert: "You are not allowed to delete this comment."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
