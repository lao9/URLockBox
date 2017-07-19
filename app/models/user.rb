class User < ApplicationRecord
  has_secure_password
  has_many :links
  validates :email, presence: true, uniqueness: true

  def check_user_errors(params)
    messages = []
    messages << "Email account already exists!" if User.find_by(email: params[:email])
    messages << "Please fill out email field." unless params[:email]
    messages << "Please fill out password field." unless params[:password]
    messages << "Please fill out password confirmation field." unless params[:pass_confirm]
    messages << "Password confirmation does not match." if params[:password] != params[:pass_confirm]
    return messages.join("\n")
  end

end
