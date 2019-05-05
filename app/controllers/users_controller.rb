class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :login_user?, only:[:edit, :update, :destroy]
  before_action :new_book_definition, only:[:index, :show]

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.reverse
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), success: 'User info was updated successfully.'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

  def login_user?
    user = User.find(params[:id])
    if user != current_user
      redirect_to user_path(current_user)
    end
  end

end
