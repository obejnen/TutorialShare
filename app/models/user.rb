class User < ApplicationRecord

  # mount_uploader :image, ImageUploader

  has_many :tutorials

  # has_many :commenting
  # has_many :comments, through: :commenting

  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :authentication_keys => {email: true, login: false}

  # attr_accessor :avatar, :avatar_cache, :remove_avatar

  # validates_presence_of   :avatar
  # validates_integrity_of  :avatar
  # validates_processing_of :avatar

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
end
