class Comment < ApplicationRecord
    
    after_create_commit { RenderCommentJob.perform_later self }

    belongs_to :commentable
    belongs_to :user
    acts_as_votable

    def tutorial
        Tutorial.find self.commentable_id
    end

    def is_liked_by(user)
        self.get_likes.voters.include?(user)
    end
end