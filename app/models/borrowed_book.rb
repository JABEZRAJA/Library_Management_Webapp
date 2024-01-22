class BorrowedBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :borrow_date, :return_date
  after_commit :send_email_user
  validates :user_id, uniqueness: { scope: [:book_id, :returned], message: 'You have already borrowed this book.' }, if: -> { returned == false }

  def send_email_user
    # yet to come
  end
end
