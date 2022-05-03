class Api::UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:create, :show]
    def create 
        user = User.create(user_params)
        if user.valid? 
            session[:user_id] = user.id 
            render json: user, status: :created 
        else 
            render json: user.errors.full_messages, status: :unprocessable_entity 
        end
    end

    def destroy 
        user = User.find_by(id: params[:id])
        if user 
            user.destroy 
            head :no_content 
        else
            render json: "User does not exist", status: :not_found 
        end
    end

    def index 
        users = User.all 
        render json: users
    end

    def show 
        if current_user 
            render json: current_user, status: :ok 
        else 
            render json: "Not authorized, please log in.", status: :unauthorized 
        end
    end

    private 
    def user_params 
        params.permit(:username, :password, :password_confirmation, :email)
    end
end
