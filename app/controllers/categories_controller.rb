class CategoriesController <ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    

    def new
        @category = Category.new
        authorize @category
    end

    def show
        authorize @category
        @books = @category.books
    end

    def index 
        @categories = Category.paginate(page: params[:page], per_page: 5)
        authorize @categories
    end

    def edit
      authorize @category
    end

    def update
      authorize @category
        if @category.update(category_params)
          flash[:notice] = "Your Category was successfully updated"
          redirect_to categories_path
        else
          render 'edit'
        end
        end

    def create
        @category = Category.new(category_params)
        authorize @category
        if @category.save
            flash[:noitce] = "Category Saved Successfully"
            redirect_to categories_path 
        else
            render 'new'
        end
    end

    def destroy
        authorize @category
        @books = @category.books
        @books.each do |book|
          if book.categories.count == 1
            book.destroy
          end
        end
        @category.destroy 
        flash[:alert] = "Your Category was successfully Deleted"
        redirect_to categories_path  
      end
    
    private

    def set_user
        @category = Category.find(params[:id])
      end


    def category_params
        params.require(:category).permit(:name)
    end

    
end