class BooksController < ApplicationController


    before_action :set_books, only: [:show, :edit, :update, :destroy]

     

    def index
        @books = Book.paginate(page: params[:page], per_page: 5) 
        authorize @books
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
        redirect_to (@book)
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
    def add_book
        @book = Book.find(params[:id])
        
     if @book.status == true
            @book.status = false
            current_user.books << @book
        if current_user.save
        flash[:notice] = "Book Successfully added to #{current_user.username}"
        else
            flash[:alert] = "Somthing Wrong Failed!!"
        end
    else
        flash[:alert] = "Cant Add this Book Not Availabe!"  
    end
        redirect_to books_path
      end

      def remove_book
            @book = Book.find(params[:id])
            @book.status = true
            @book.save
            if current_user.books.delete(@book)
            flash[:alert] = "Book Successfully Removed"
            else
                flash[:alert] = "Somthing Wrong Failed!!"
            end
            redirect_to books_path
      end

    private 

    def set_books
        @book = Book.find(params[:id])
    end

    def book_params
        params.require(:book).permit(:name, :author,category_ids: [])
    end

end
