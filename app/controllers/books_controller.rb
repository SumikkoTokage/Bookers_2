class BooksController < ApplicationController

    before_action :authenticate_user!, only: [:create, :index, :new, :show, :edit, :update, :destroy]

    def top
    end

    def about
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            redirect_to book_path(@book), notice: "Create Successfully!"
        else
            render :new
        end
    end
    def index
        @books = Book.all
        @book = Book.new
        @user = User.find_by(id: current_user.id)
    end
    def new
        @book = Book.new
    end
    def show
        @book = Book.find(params[:id])
        @new_book = Book.new
        @user = User.find_by(id: current_user.id)
    end
    def edit
        @book = Book.find(params[:id])
	end
    def update
        book = Book.find(params[:id])
        book.update(book_params)
        redirect_to book_path(book.id), notice: "Update Successfully!"
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
