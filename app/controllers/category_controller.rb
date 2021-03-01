class CategoryController < ApplicationController
    before_action :find_category, only: [:show, :destroy, :update]

    def index
        @categories = Category.all
        render json: @categories.to_json(include: [:products])
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            head 201
        else
            head 400
        end
    end

    def show
        if @category
            render json: @category.to_json(include: [:products])
        else
            head 404
        end
    end

    def destroy 
        if @category
            if @category.products.any?
                head 409
            else 
                @category.destroy
            end
        else
            head 404
        end
    end

    def update
        if @category
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
    def category_params
        params.require(:category).permit(:name, product_ids: [])
    end

    def find_category
        @category = Category.find(params[:id])
    end

end