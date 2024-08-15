class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_one_attached :image

  validates :nickname, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\Z/i
  validates :password, format: { with: PASSWORD_REGEX, message: 'には半角の英語と数字両方を含めてください' }
end
