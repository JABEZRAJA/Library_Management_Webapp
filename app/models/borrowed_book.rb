class BorrowedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :borrow_date, presence: true
  validates :return_date, presence: true
  validates :user_id, uniqueness: { scope: [:book_id, :returned], message: 'You have already borrowed this book.' }, if: -> { returned == false }

  # after_commit :send_email_user

  # def send_email_user
  #   # Implementation for sending email to the user after book is borrowed.
  # end
end
