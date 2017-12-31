class Admin::AdminController < ApplicationController
    before_action :check_for_admin

    layout "admin_layout"

    protected

    def check_for_admin
         redirect_to root_path unless current_user.admin?
    end
end