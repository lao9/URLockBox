class User < ApplicationRecord
  has_secure_password

  has_many :links

  validates :email, presence: true
end
