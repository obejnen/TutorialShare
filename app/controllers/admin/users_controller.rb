class Admin::UsersController < Admin::AdminController
    before_action :set_user, only: [:ban, :change_role]

    def index
        @users = User.all
    end

    def ban
        @user.banned = @user.banned ? false : true
        @user.save
        redirect_to admin_users_path
    end

    def change_role
        @user.admin = @user.admin ? false : true
        @user.save
        redirect_to admin_users_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end