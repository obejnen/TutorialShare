class Admin::CommentsController < Admin::AdminController
    def index
        @comments = Comment.all
    end
end