class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchase_records

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字を含めてください' }

  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字で入力してください' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字で入力してください' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カナで入力してください' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カナで入力してください' }
  end
end
