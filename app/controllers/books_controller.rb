class BooksController < ApplicationController


    before_action :set_books, only: [:show, :edit, :update, :destroy]

    def index
        @books = policy_scope(Book.paginate(page: params[:page], per_page: 10))
    end

    def show
        authorize @book  
    end

    def new 
        @book = Book.new
        authorize @book 
    end

    def edit
        authorize @book
    end


    def create
        @book = Book.new(book_params)
        authorize @book
       if @book.save
        flash[:notice] = "Book Saved Successfully"
        redirect_to books_path
       else
          render 'new'
       end
    end

    def update 
        authorize @book 
        if @book.update(book_params)
        flash[:notice] = "Book Updated Successfully"
        redirect_to books_path
        else 
            render 'edit'
        end
    end

    def destroy
        authorize @book
        @book.destroy
        redirect_to books_path
    end
     
    private 

    def set_books
        @book = Book.find(params[:id])
    end

    def book_params
        params.require(:book).permit(:name, :author,:total,:quantity,category_ids: [])
    end

end
