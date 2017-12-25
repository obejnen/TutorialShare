class User < ApplicationRecord

  has_many :tutorials

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
         
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
end
