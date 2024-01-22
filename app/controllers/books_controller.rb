class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by(id: params[:id])
    return if @book.present?

    render json: { error: 'Book not found' }, status: 404
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
      @book.user_id = current_user.id
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
    # coming soon
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

  def search
    @books = Book.where("title LIKE ?", "%#{params[:query]}%")
    render 'index'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :author_name, :description, :copies, :published_date, :image, :genre)
  end
end
