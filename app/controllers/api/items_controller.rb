class Api::ItemsController < ApplicationController
   before_action :set_items, only: [:show, :update, :destroy]
   before_action :is_authorized, only: [:update, :destroy]
    def index 
        items = Item.where(sold: false) 
        render json: items
    end
    def show 
        
        if @item 
            render json: @item 
        else
            render json: { error: @item.errors.full_messages}, status: :not_found 
        end
    end
    def create 
        item = current_user.sold_items.create(item_params)
        if item.valid? 
            render json: item, status: :created 
        else
            render json: {error: item.errors.full_messages}, status: :unprocessable_entity 
        end 
    end
    def update 
        
        if @item.valid? 
            @item.update(item_params)
            render json: @item, status: :ok 
        else 
            render json: @item.errors.full_messages, status: :unprocessable_entity 
        end

    end
    def destroy 
        @item.destroy 
        head :no_content 
    end

    private 
    def is_authorized 
        permitted = current_user.admin? || @item.seller == current_user 
        render json: "Access not permitted", status: :forbidden unless permitted
    end
    def set_items 
        @item = Item.find_by(id: params[:id])
    end
    def item_params 
        params.permit(:name, :desc, :price)
    end
end
