class CommentMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def new_comment(comment)
    @comment = comment
    @post = comment.post
    @post_author = @post.user

    mail(
      to: @post_author.email,
      subject: "New comment on your post: #{@post.title}"
    )
  end
end
