class ProductController < ApplicationController
    before_action :find_product, only: [:show, :destroy, :update]

    def index
        @products = Product.all
        render json: @products.to_json(include: [:categories])
    end

    def create
        if !product_params[:category_ids].empty?
            @product = Product.new(product_params)
            
            if @product.save
                head 201
            else
                head 400
            end
        else
            head 400
        end
        
    end

    def show
        if @product
            render json: @product.to_json(include: [:categories])
        else 
            head 404
        end
    end

    def destroy
        if @product 
            if @product.destroy and @product.categories.clear
                head 200
            else
                head 409
            end
        else
            head 404
        end 
    end

    def update
        if @product
            @product.categories.clear

            if @product.update(product_params)
                head 200
            else
                head 409
            end
        else 
            head 404
        end
    end
            
    private 
    def product_params
        params.require(:product).permit(:name, category_ids: [])
    end
    def find_product
        @product = Product.find(params[:id])
    end

end