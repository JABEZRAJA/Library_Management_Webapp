class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :genre, presence: true
end
