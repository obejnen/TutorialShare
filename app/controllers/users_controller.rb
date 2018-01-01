class UsersController < ApplicationController
    before_action :set_user_show, only: [:show]
    before_action :set_user_contents, only: [:tutorials, :comments]


    def show
    end

    def tutorials
    end

    def comments
    end

    private

    def set_user_show
        @user = User.find(params[:id])
    end

    def set_user_contents
        @user = User.find(params[:user_id])
        @tutorials = @user.tutorials
        @comments = @user.comments
    end
end