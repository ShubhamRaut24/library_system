class PagesController < ApplicationController
    before_action :authenticate_user!
    def home 
        if user_signed_in?
            @books = current_user.books
        end    
    end
     
end
