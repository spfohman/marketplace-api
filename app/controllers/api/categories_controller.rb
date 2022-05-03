class Api::CategoriesController < ApplicationController
    def index 
        categories = Category.all 
        render json: categories, include: ['items', 'items.seller']
    end

    def show 
        category = Category.find(params[:id])
        render json: category
    end
end
