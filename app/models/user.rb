class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader
  ratyrate_rater
  acts_as_voter

  has_many :tutorials
  
  has_many :comments

  validates :username, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :confirmable, :authentication_keys => {email: true, login: false},
         omniauth_providers: [:facebook, :twitter, :vkontakte]


  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def set_locale(locale)
    self.locale = locale
    self.save
  end

  def set_theme(color)
    self.theme = color
    self.save
  end

  def self.from_omniauth(auth, provider)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = self.send("username_#{provider}", auth)
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.username_twitter(auth)
    auth.info.name
  end

  def self.username_facebook(auth)
    auth.name
  end

  def self.username_vkontakte(auth)
    auth.info.name    
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end
end
