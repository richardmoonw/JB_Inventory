class CategoryController < ApplicationController
    before_action :find_category, only: [:show, :destroy, :update]

    # Get all the categories.
    def index
        @categories = Category.all
        render json: @categories.to_json(include: [:products])
    end

    # Create a new category.
    def create
        @category = Category.new(category_params)
        if @category.save
            head 201
        else
            head 400
        end
    end

    # Get a specific category.
    def show
        if @category
            render json: @category.to_json(include: [:products])
        else
            head 404
        end
    end

    # Delete a category.
    def destroy 
        if @category
            
            # If the category has products 
            if @category.products.any?
                head 409
            else 
                @category.destroy
            end
        else
            head 404
        end
    end

    # Update a category.
    def update
        if @category
            # Clear all the products that the category has and add the new ones.
            @category.products.clear
            if @category.update(category_params)
                head 200
            else
                head 409
            end
        else
            head 404
        end
    end

    private
    # Catch the parameters of the request.
    def category_params
        params.require(:category).permit(:name, product_ids: [])
    end

    def find_category
        @category = Category.find(params[:id])
    end

end