class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy, :like]
    before_action :find_commentable
    before_action :set_comment, only: [:destroy]
    before_action :set_comment_to_like, only: [:like]
    respond_to :js, :json, :html

    def new
        @comment = Comment.new
    end

    def create
        @comment = @commentable.comments.new(comment_params)
        @comment.save
        redirect_to @commentable
    end

    def destroy
        @comment.destroy
    end

    def like
        unless current_user.liked? @comment
            @comment.liked_by current_user
        else
            @comment.unliked_by current_user
        end
        # redirect_to root_path
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def set_comment_to_like
        @commentable = Tutorial.find(params[:id])
        @comment = @commentable.comments.find(params[:tutorial_id])
    end

    def comment_params
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

    def find_commentable
        @commentable = Tutorial.find_by_id(params[:tutorial_id])
        #  if params[:tutorial_id]
    end
end