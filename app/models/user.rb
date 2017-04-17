class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :auth_token

 
  def info
    "#{email} - #{created_at} - Token: #{Devise.friendly_token}"
  end
end
