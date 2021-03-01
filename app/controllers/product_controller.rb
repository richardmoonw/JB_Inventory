class ProductController < ApplicationController
    before_action :find_product, only: [:show, :destroy, :update]

    # Get all the products.
    def index
        @products = Product.all
        render json: @products.to_json(include: [:categories])
    end

    # Create a new product.
    def create
        # Unless any category was specified.
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

    # Get a specific product.
    def show
        if @product
            render json: @product.to_json(include: [:categories])
        else 
            head 404
        end
    end

    # Delete a product.
    def destroy
        if @product 
            # Clear all the categories that the product has and add the new ones.
            if @product.categories.clear and @product.destroy
                head 200
            else
                head 409
            end
        else
            head 404
        end 
    end

    # Update a product.
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
    # Catch the parameters of the request.
    def product_params
        params.require(:product).permit(:name, category_ids: [])
    end
    def find_product
        @product = Product.find(params[:id])
    end

end