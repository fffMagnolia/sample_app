class User < ApplicationRecord
  # Railsの魔法でカラムがインスタンス変数としてマッピングされている
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save { email.downcase! }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # ログインテストの際、パスワードの正誤を確認するのに必要
  # テストの際は計算コストを最小限にする
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end