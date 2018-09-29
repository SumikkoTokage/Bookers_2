class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def index
    @users = User.all
    @new_book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@new_book = Book.new
  	@books = @user.books.page(params[:page]).reverse_order
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	 redirect_to user_path(@user.id)
    else
     render action: :edit
    end
  end

  def edit
  	@user = User.find(params[:id])
    if @user.id == current_user.id
    else
      redirect_to users_path
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
