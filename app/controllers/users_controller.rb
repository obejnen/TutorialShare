class UsersController < ApplicationController
    before_action :set_user


    def show
    end

    def tutorials
    end

    private

    def set_user
        @user = User.find(params[:id])
        @tutorials = @user.tutorials
    end
end