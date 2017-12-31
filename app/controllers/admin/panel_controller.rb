class Admin::PanelController < ApplicationController
    before_action :authenticate_user!

    layout "admin_layout"

    def index
    end

    def tutorials
        @tutorials = Tutorial.all
    end

    def users
        @users = User.all
    end

end
