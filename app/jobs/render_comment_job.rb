class RenderCommentJob < ApplicationJob

  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "tutorial:#{comment.commentable_id}:comments", comment: render_comment(comment)
  end

  private
    def render_comment(comment)
      # ApplicationController.renderer.render(partial: 'comments/comment', locals: { comment: comment })
      ApplicationController.render_with_signed_in_user(comment.user, partial: 'comments/comment', locals: { comment: comment })      
    end
end