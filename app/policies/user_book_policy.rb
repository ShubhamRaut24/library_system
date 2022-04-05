class UserBookPolicy< ApplicationPolicy
    
    attr_reader :user, :user_book


     
    def initialize(user, user_book)
        @user = user
        @user_book = user_book
    end


    def new?
        @user!=nil
    end

    def create?
        @user!=nil and @user.id == @user_book.user_id
    end

    def destroy?
        @user!=nil and @user.id == @user_book.user_id
    end



end