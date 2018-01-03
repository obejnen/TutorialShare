class Comment < ApplicationRecord
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