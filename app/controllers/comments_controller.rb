def create
  @comment = @post.comments.build(comment_params)
  if @comment.save
    redirect_to @post, notice: t('comments.created')
  else
    redirect_to @post, alert: t('comments.errors.blank')
  end
end
