class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :borrowed_books, dependent: :destroy
  has_many :users, through: :borrowed_books, dependent: :destroy

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :author_name, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
  validates :copies, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :published_date, presence: true
  validates :image, presence: true
  validates :genre, presence: true
end
