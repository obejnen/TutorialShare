class UsersController < ApplicationController
    before_action :set_user_show, only: [:show]
    before_action :set_user_contents, only: [:tutorials, :comments]


    def show
    end

    def tutorials
        @search = @user.tutorials.ransack(params[:q])
        @tutorials = @search.result
    end

    def comments
        @search = @user.comments.ransack(params[:q])        
        @comments = @search.result
    end

    def set_locale
        current_user.set_locale(params[:locale])
        redirect_back fallback_location: root_path
    end

    def set_theme
        current_user.set_theme(params[:theme])
        redirect_back fallback_location: root_path
    end

    private

    def set_user_show
        @user = User.find(params[:id])
    end

    def set_user_contents
        @user = User.find(params[:user_id])
    end

end