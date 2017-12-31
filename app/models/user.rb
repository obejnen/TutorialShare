class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader

  has_many :tutorials

  # has_many :commenting
  # has_many :comments, through: :commenting
  
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :authentication_keys => {email: true, login: false}


  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def status
    "Banned" if self.banned? else "OK"
  end
end
