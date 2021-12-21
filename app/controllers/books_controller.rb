class BooksController < ApplicationController
  
  before_action :move_to_books, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @book2 = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def move_to_books
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
