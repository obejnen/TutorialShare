module Admin::UsersHelper
    def status(user)
        return user.banned ? "Banned" : "Ok"
    end

    def role(user)
        return user.admin ? "Admin" : "User"
    end

    def ban_btn_text(user)
        return user.banned ? "Unban" : "Ban"
    end
end