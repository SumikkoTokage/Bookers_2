class BooksController < ApplicationController

    before_action :authenticate_user!, only: [:create, :index, :new, :show, :edit, :update, :destroy]

    def top
    end

    def about
    end

    def create
        @new_book = Book.new(book_params)
        @new_book.user_id = current_user.id
        @user = current_user
        if @new_book.save
        redirect_to book_path(@new_book.id), notice: "Create Successfully!"
        else
            @books = Book.all
            render 'index'
        end
    end
    def index
        @books = Book.all
        @new_book = Book.new
        @user = User.find_by(id: current_user.id)
    end
    def new
        @new_book = Book.new
    end
    def show
        @book = Book.find(params[:id])
        @new_book = Book.new
        @user = User.find_by(id: current_user.id)
    end
    def edit
        @book = Book.find(params[:id])
        if @book.user_id == current_user.id
        else
            redirect_to books_path
        end
	end
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        redirect_to book_path(@book.id), notice: "Update Successfully!"
        else
            render action: :edit
        end
    end
	def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
	end

    private

    def book_params
        params.require(:book).permit(:title, :opinion, :user_id)
    end
end
