class ApplicationController < ActionController::API
include ActionController::Cookies
before_action :authenticate_user
    private 

    def authenticate_user 
        render json: "Not authorized", status: :unauthorized unless current_user
    end

    def current_user 
        User.find_by(id: session[:user_id])
    end
end
