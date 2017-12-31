class Comment < ApplicationRecord
    belongs_to :commentable
    belongs_to :user

    def tutorial
        Tutorial.find self.commentable_id
    end
end
