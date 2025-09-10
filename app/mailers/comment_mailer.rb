class CommentMailer < ApplicationMailer
    
  def new_comment_email(comment)
    @comment = comment
    @post = comment.post
    @post_author = @post.user
    mail(to: @post_author.email, subject: "New comment on your post")
  end
end
