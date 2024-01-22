class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :users, through: :borrowed_books, dependent: :destroy
  has_many :borrowed_books, dependent: :destroy

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :genre, presence: true
end