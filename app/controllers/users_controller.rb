class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy]
   

    def show
      authorize @user
      @books = @user.books  
    end

    def index 
      @users = User.paginate(page: params[:page], per_page: 3)
      authorize @users
    end

    def destroy
    authorize @user
    @books = @user.books 
    @books.each do |b| 
      b.status = true
      b.quantity = b.quantity+1
      b.save
    end 
    @user.destroy
    redirect_to users_path 
     
  end

    private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end


  def set_user
  @user = User.find(params[:id])
  end  


   


end
