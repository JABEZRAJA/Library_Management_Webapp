class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    if current_user.role == 'admin'
      @book = Book.new
    else
      redirect_to books_path, alert: 'Only admin users can create books.'
    end
  end

  def create
    if current_user.role == 'admin'
      @book = Book.new(book_params)
      @book.user = current_user
      if @book.save
        redirect_to @book, notice: 'Book was successfully created.'
      else
        render :new
      end
    else
      redirect_to books_path, alert: 'Only admin users can create books.'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :author_name, :description, :copies, :published_date, :image, :genre)
  end
end
