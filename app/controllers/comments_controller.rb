class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show] # Require login for all except show
  before_action :set_post
  before_action :set_comment, only: [:show, :destroy, :edit, :update]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      CommentMailer.new_comment_email(@comment).deliver_now

      redirect_to @post, notice: "Comment added successfully."
    else
      redirect_to @post, alert: "Failed to add comment."
    end
  end

  def show
  end

  def destroy
    if @comment.user_id == current_user&.id
      @comment.destroy
      redirect_to @post, notice: "Comment deleted."
    else
      redirect_to @post, alert: "You are not allowed to delete this comment."
    end
  end


  def edit
    unless @comment.user_id == current_user&.id
      redirect_to @post, alert: "You are not allowed to edit this comment."
    end
  end

  def update
    if @comment.user_id == current_user&.id
      if @comment.update(comment_params)
        redirect_to @post, notice: "Comment updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to @post, alert: "You are not allowed to edit this comment."
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
