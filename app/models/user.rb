class User < ApplicationRecord
  has_many :books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  validates :name, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
end
