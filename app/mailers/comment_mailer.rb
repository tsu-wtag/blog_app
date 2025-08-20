class CommentMailer < ApplicationMailer
  def notify_post_author(comment_id)
    @comment = Comment.find(comment_id)
    @post = @comment.post
    @user = @post.user

    mail(to: @user.email, subject: "New comment on your post")
  end
end
