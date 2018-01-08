class ApplicationController < ActionController::Base
  DEFAULT_BASE_COLOR = "light"
  DEFAULT_BOOTSTRAP_TEMPLATE = "default"
  protect_from_forgery prepend: true

  add_flash_types :success, :danger, :warning, :info

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_top_tutorials
  before_action :set_sidebar
  before_action :set_settings

  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_sidebar
    @sidebar = request.original_url.include?("/admin/") ? "admin" : "default"
  end

  def set_settings
    if user_signed_in?
      I18n.locale = current_user.locale
      @color = current_user.theme
      @bootstrap_template = @color == "dark" ? 'inverse' : 'default'
    else
      I18n.locale = I18n.default_locale
      @color = DEFAULT_BASE_COLOR
      @bootstrap_template = DEFAULT_BOOTSTRAP_TEMPLATE
    end
  end

  def set_top_tutorials
    @top_tutorials = Tutorial.all.sort {|a,b| a.rating <=> b.rating}[0..4]
end
end