class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :like]
    before_action :find_commentable
    before_action :check_for_admin, only: [:destroy]
    before_action :set_comment, only: [:destroy]
    before_action :set_comment_to_like, only: [:like]
    respond_to :js, :json, :html

    def new
        @comment = Comment.new
    end

    def create
        @comment = @commentable.comments.new(comment_params)
        @comment.save
    end

    def index
        @comments = @commentable.comments
    end

    def destroy
        @tutorial = @comment.tutorial
        @comment.destroy
        unless params[:view_name].present?
            redirect_to tutorial_path(@tutorial)
        end
    end


    def show
        @comment = Comment.find(params[:id])
    end

    def like
        unless current_user.liked? @comment
            @comment.liked_by current_user
        else
            @comment.unliked_by current_user
        end
    end

    private

    def check_for_admin
        user_signed_in? && current_user.admin?
    end

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
        @tutorial = @commentable
    end
end