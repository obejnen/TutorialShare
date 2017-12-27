class Admin::PanelController < ApplicationController
    before_action :authenticate_user!
    before_action :check_for_admin

    def index
    end

    def tutorials
        @tutorials = Tutorial.all
    end

    def users
        @users = User.all
    end

    protected

    def check_for_admin
        redirect_to root_path unless current_user.admin?
    end
end
