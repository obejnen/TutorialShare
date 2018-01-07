class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader
  ratyrate_rater
  acts_as_voter

  has_many :tutorials
  
  has_many :comments

  validates :username, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :authentication_keys => {email: true, login: false}


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
end
