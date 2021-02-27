class ProductController < ApplicationController
    before_action :find_product, only: [:show, :destroy, :update]

    def index
        @products = Product.all
        render json: @products
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            head 201
        else
            head 400
        end
    end

    def show
        if @product
            render json: @product
        else 
            head 404
        end
    end

    def destroy
        if @product 
            if @product.destroy
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
        params.require(:product).permit(:name)
    end
    def find_product
        @product = Product.find(params[:id])
    end

end