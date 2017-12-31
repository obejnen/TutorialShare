class CommentsController < ApplicationController
    before_action :find_commentable

    def new
        @comment = Comment.new
    end

    def create
        @comment = @commentable.comments.new(comment_params)
        if @comment.save
            redirect_to @commentable
        else
            redirect_to @commentable
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

    def find_commentable
        @commentable = Tutorial.find_by_id(params[:tutorial_id])
        #  if params[:tutorial_id]
    end
end