class BorrowedBooksController < ApplicationController
  before_action :set_borrowed_book, only: [:show, :edit, :update, :destroy]
  before_action :validate_borrowed_books, only: [:create]

  def index
    @borrowed_books = BorrowedBook.all
  end

  #   def show
  #   end

  def new
    @borrowed_book = BorrowedBook.new
  end

  def create
    @book = Book.find(params[:book_id])

    unless current_user.can_borrow?(@book)
      flash[:alert] = 'You have already borrowed this book.'
      redirect_to books_path and return
    end

    @borrowed_book = BorrowedBook.new(book: @book, user: current_user, borrow_date: Time.now, return_date: (Date.current + 8))

    respond_to do |format|
      if @borrowed_book.save!
        @book.update(copies: @book.copies - 1)

        format.js { flash.now[:notice] = 'Book borrowed successfully.' }
      else
        format.js { flash.now[:alert] = 'Failed to borrow the book.' }
      end
    end
  end

  def update
    if @borrowed_book.update(borrowed_book_params)
      redirect_to borrowed_books_path, notice: 'Borrowed book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if params[:id] == 'user_borrowed_books'
      user_borrowed_book = current_user.borrowed_books.find_by(id: params[:borrowed_book_id])

      if user_borrowed_book
        user_borrowed_book.book.update(copies: user_borrowed_book.book.copies + 1)
        user_borrowed_book.destroy
        redirect_to authenticated_root_path, notice: 'Borrowed book was successfully returned.'
      else
        redirect_to authenticated_root_path, alert: 'Borrowed book not found.'
      end
    else
      @borrowed_book.book.update(copies: @borrowed_book.book.copies + 1)
      @borrowed_book.destroy
      redirect_to authenticated_root_path, notice: 'Borrowed book was successfully returned.'
    end
  end

  def user_borrowed_books
    @user_borrowed_books = current_user.borrowed_books
  end

  private

  def set_borrowed_book
    @borrowed_book = BorrowedBook.find(params[:id])
  end

  def validate_borrowed_books
    book_id = params[:book_id]
    if current_user.already_borrowed?(book_id)
      flash[:alert] = 'You have already borrowed this book.'
      redirect_to books_path and return
    end
  end

  def borrowed_book_params
    params.require(:borrowed_book).permit(:user_id, :book_id, :borrow_date, :return_date)
  end
end
