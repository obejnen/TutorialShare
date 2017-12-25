class Admin::PanelController < AppliactionController
    before_action :authenticate_user!
    before_action :check_for_admin

    def index
    end

    protected

    def check_for_admin
        redirect_to root_path unless current_user.admin?
    end
end