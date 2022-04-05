class UserBooksController < ApplicationController


    # def index
    # @user_books = UserBook.all
    # end

    def new 
        @books = Book.all
        @user_book = UserBook.new()
        authorize @user_book
    end

    def create
        @user_book = UserBook.new(user_id:params[:user_id],book_id:params[:book_id])
        authorize @user_book
        @book = Book.find(@user_book.book_id)

        if @book.status == true && @book.quantity!=0
            @books = current_user.books
            flag = true
            @books.each do |b|
                 if b.name == @book.name
                    flag = false
                 end
            end
             if flag == true
             @book.quantity = @book.quantity - 1
             if @book.quantity == 0
                @book.status = false
             end
             @book.save 

             @user_book.save
             flash[:notice] = "Book Successfully added to #{current_user.username}"
             redirect_to root_path
            else
                redirect_to new_user_book_path
                flash[:alert] = "Already Added" 
            end
        else
            @book.status = false
            @book.save
            redirect_to new_user_book_path
            flash[:alert] = "Cant Add this Book Not Availabe!"  
        end
            
    end

    def destroy
        @user_book = UserBook.find(params[:id])
        authorize @user_book
        @book = Book.find(@user_book.book_id)
        @book.status = true
        @book.quantity =  @book.quantity + 1
        @book.save
        if @user_book.destroy
            redirect_to root_path     
        flash[:alert] = "Book Successfully Removed" 
        else
            redirect_to root_path 
        flash[:alert] = "Somthing Wrong Failed!!"
        end   
               
    end

end
