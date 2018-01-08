class ApplicationController < ActionController::Base
  DEFAULT_BASE_COLOR = "light"
  DEFAULT_BOOTSTRAP_TEMPLATE = "default"
  protect_from_forgery prepend: true

  add_flash_types :success, :danger, :warning, :info

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_sidebar
  before_action :parse_youtube
  before_action :set_settings

  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end

  protected

  def youtube_link(source_url)
    regex = /((?:https|http):\/\/\w{0,3}.youtube+\.\w{2,3}\/watch\?v=[\w-]{11})/
    regex.match(source_url).to_s
end

def get_youtube_id(url)
    id = ''
    url = url.gsub(/(>|<)/i,'').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/)
    if url[2] != nil
      id = url[2].split(/[^0-9a-z_\-]/i)
      id = id[0];
    else
      id = url;
    end
    id
end

  def parse_youtube
    @text = "выфвыф dsadsadsdsa https://www.youtube.com/watch?v=6WbyLhsOvpE dsaiohfwr"
    link = youtube_link(@text)
    @text = @text.sub(link, "<iframe width='420' height='315' src='https://www.youtube.com/embed/#{get_youtube_id(link)}'></iframe>")
  end

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_sidebar
    @sidebar = params[:view_name].present? ? "admin" : "default"
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
end