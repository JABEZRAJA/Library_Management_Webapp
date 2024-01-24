class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :books, through: :borrowed_books, dependent: :destroy
  has_many :borrowed_books, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  enum role: [:user, :admin]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Method to check if the user can borrow a specific book
  def can_borrow?(book)
    !already_borrowed?(book.id)
  end

  # Method to check if the user has already borrowed a specific book
  def already_borrowed?(book_id)
    borrowed_books.where(book_id: book_id, returned: false).exists?
  end
end
