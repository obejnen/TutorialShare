class Admin::PanelController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def tutorials
        @tutorials = Tutorial.all
    end

    def users
        @users = User.all
    end

end
