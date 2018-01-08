class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
        user = User.from_omniauth(request.env["omniauth.auth"], :facebook)
        sign_in_and_redirect user
        if user.persisted?
            sign_in_and_redirect user, notice: "Signed in with facebook!"
        else
            session["devise.user_attributes"] = user.attributes
            redirect_to new_user_registration_path
        end
    end

    def twitter
        user = User.from_omniauth(request.env["omniauth.auth"], :twitter)
        if user.persisted?
            sign_in_and_redirect user, notice: "Signed in with twitter!"
        else
            session["devise.user_attributes"] = user.attributes
            redirect_to new_user_registration_path
        end
        # sign_in_and_redirect @user
        # raise request.env['omniauth.auth']
    end

    def vkontakte
        user = User.from_omniauth(request.env["omniauth.auth"], :vkontakte)
        if user.persisted?
            sign_in_and_redirect user, notice: "Signed in with vkontakte!"
        else
            session["devise.user_attributes"] = user.attributes
            redirect_to new_user_registration_path
        end
    end
end