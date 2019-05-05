class BooksController < ApplicationController
  before_action :authenticate_user!, only:[
    :index, :show, :edit,
    :create, :update, :destroy
  ]
  before_action :login_user?, only:[:edit, :update, :destroy]
  before_action :new_book_definition, only:[:index, :show]

  def top
  end

  def about
  end

  def index
    @user = current_user
    @books = Book.all.reverse
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book), success: 'New book was created successfully.'
    else
      @user = current_user
      @books = Book.all.reverse
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), success: 'A book was updated successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, success: 'A Book was destroyed successfully.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def login_user?
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    end
  end
end
