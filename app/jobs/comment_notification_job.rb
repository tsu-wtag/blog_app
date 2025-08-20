class CommentNotificationJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    CommentMailer.notify_post_author(comment_id).deliver_now
  end
end
